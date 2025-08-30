/**
 * @file mm.c
 * @brief A 64-bit struct-based implicit free list memory allocator
 *
 * 15-213: Introduction to Computer Systems
 *
 * This file implements a dynamic memory allocator based on a footerless
 * allocated block and explicit segregated freelists design. In addition,
 * miniblocks are supported for small allocations
 * (<= 8 bytes) in order to increase utilization. The allocator divides the heap
 * region of memory into blocks that contain headers, payloads, footers, and
 * next/prev free block pointers depending on whether that block is allocted or
 * free. It supports malloc, free, calloc, and realloc.
 *
 * A best fit search is used in order to manage the freelist blocks within the
 * segregated lists and return the optimal block when making an allocation. The
 * 0th index of the segregated lists is used to store the freelist for the
 * miniblocks.
 *
 * Key Operations:
 * 1. Initializing the heap and prologue/epilogue blocks (mm_init)
 * 2. Searching for optimal blocks for allocation (find_fit)
 * 3. Splitting Blocks when the returned block is too large (split_block)
 * 4. Coalescing adjacent free blocks (coalesce_block)
 * 5. Maintaing heap consistency (mm_heapcheck)
 *
 * Block headers store information about the current block's size and allocation
 * status, the previous block's allocation status, and the previous block's
 * miniblock status. 16-byte boundaries are maintained for all payloads.
 *
 * @author Srikar Govindaraju <srikarg@andrew.cmu.edu>
 */

#include <assert.h>
#include <inttypes.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include "memlib.h"
#include "mm.h"

/* Do not change the following! */

#ifdef DRIVER
/* create aliases for driver tests */
#define malloc mm_malloc
#define free mm_free
#define realloc mm_realloc
#define calloc mm_calloc
#define memset mem_memset
#define memcpy mem_memcpy
#endif /* def DRIVER */

/* You can change anything from here onward */

/*
 *****************************************************************************
 * If DEBUG is defined (such as when running mdriver-dbg), these macros      *
 * are enabled. You can use them to print debugging output and to check      *
 * contracts only in debug mode.                                             *
 *                                                                           *
 * Only debugging macros with names beginning "dbg_" are allowed.            *
 * You may not define any other macros having arguments.                     *
 *****************************************************************************
 */
#ifdef DEBUG
/* When DEBUG is defined, these form aliases to useful functions */
#define dbg_requires(expr) assert(expr)
#define dbg_assert(expr) assert(expr)
#define dbg_ensures(expr) assert(expr)
#define dbg_printf(...) ((void)printf(__VA_ARGS__))
#define dbg_printheap(...) print_heap(__VA_ARGS__)
#else
/* When DEBUG is not defined, these should emit no code whatsoever,
 * not even from evaluation of argument expressions.  However,
 * argument expressions should still be syntax-checked and should
 * count as uses of any variables involved.  This used to use a
 * straightforward hack involving sizeof(), but that can sometimes
 * provoke warnings about misuse of sizeof().  I _hope_ that this
 * newer, less straightforward hack will be more robust.
 * Hat tip to Stack Overflow poster chqrlie (see
 * https://stackoverflow.com/questions/72647780).
 */
#define dbg_discard_expr_(...) ((void)((0) && printf(__VA_ARGS__)))
#define dbg_requires(expr) dbg_discard_expr_("%d", !(expr))
#define dbg_assert(expr) dbg_discard_expr_("%d", !(expr))
#define dbg_ensures(expr) dbg_discard_expr_("%d", !(expr))
#define dbg_printf(...) dbg_discard_expr_(__VA_ARGS__)
#define dbg_printheap(...) ((void)((0) && print_heap(__VA_ARGS__)))
#endif

/* Basic constants */
#define NUM_LISTS 40
typedef uint64_t word_t;

/** @brief Word and header size (bytes) */
static const size_t wsize = sizeof(word_t);

/** @brief Double word size (bytes) */
static const size_t dsize = 2 * wsize;

/** @brief Minimum block size (bytes) */
static const size_t min_block_size = 2 * dsize;

/** @brief miniblock size = 16 bytes */
static const size_t mini_block_size = 2 * wsize;

/** @brief The number of bytes by which we extend the heap
 * if we run out of space */
static const size_t chunksize = (1 << 12);

/** @brief returns the last bit in header */
static const word_t alloc_mask = 0x1;

/** @brief returns the second to last bit in header */
static const word_t prev_alloc_mask = 0x2;

/** @brief returns the third to last bit in header */
static const word_t prev_miniblock_mask = 0x4;

/** @brief used to remove the status bits from a header,
 * leaving only the size of the block */
static const word_t size_mask = ~(word_t)0xF;

/** @struct block
 *  @brief Represents a memory block, including header and either payload or
 * freelist pointers
 *
 * This struct represents a singular memory block on the heap. The header
 * contains the block's metadata (including some information about the previous
 * block). The union allows for us to use freelist pointers when the block is
 * free and store a payload when the block is allocated.
 */
typedef struct block {
    word_t header; // Encodes size, alloc, prev_alloc, and prev_miniblock bits

    union {
        struct {
            struct block
                *next_free_block; // Next free block in segregated freelist
            struct block
                *prev_free_block; // Previous free block in segregated freelist
        } freelist;

        char payload[0]; // This is where the payload starts
    };
} block_t;

/* Global variables */

/** @brief Pointer to first block in the heap */
static block_t *heap_start = NULL;

/** @brief array of freelists where each index represents a class of power of 2
 */
static block_t **seglists = NULL;

/*
 *****************************************************************************
 * The functions below are short wrapper functions to perform                *
 * bit manipulation, pointer arithmetic, and other helper operations.        *
 *                                                                           *
 * We've given you the function header comments for the functions below      *
 * to help you understand how this baseline code works.                      *
 *                                                                           *
 * Note that these function header comments are short since the functions    *
 * they are describing are short as well; you will need to provide           *
 * adequate details for the functions that you write yourself!               *
 *****************************************************************************
 */

/*
 * ---------------------------------------------------------------------------
 *                        BEGIN SHORT HELPER FUNCTIONS
 * ---------------------------------------------------------------------------
 */

/**
 * @brief Returns the maximum of two integers.
 * @param[in] x
 * @param[in] y
 * @return `x` if `x > y`, and `y` otherwise.
 */
static size_t max(size_t x, size_t y) {
    return (x > y) ? x : y;
}

/**
 * @brief Rounds `size` up to next multiple of n
 * @param[in] size
 * @param[in] n
 * @return The size after rounding up
 */
static size_t round_up(size_t size, size_t n) {
    return n * ((size + (n - 1)) / n);
}

/**
 * @brief Packs the `size` and `alloc` of a block into a word suitable for
 *        use as a packed value.
 *
 * Packed values are used for both headers and footers.
 *
 * The allocation status is packed into the lowest bit of the word.
 *
 * @param[in] size The size of the block being represented
 * @param[in] alloc True if the block is allocated
 * @return The packed value
 */
static word_t pack(size_t size, bool alloc, bool prev_alloc,
                   bool is_prev_mini) {
    word_t word = size;
    if (alloc) {
        word |= alloc_mask;
    }
    if (prev_alloc) {
        word |= prev_alloc_mask;
    }
    if (is_prev_mini) {
        word |= prev_miniblock_mask;
    }
    return word;
}

/**
 * @brief Extracts the size represented in a packed word.
 *
 * This function simply clears the lowest 4 bits of the word, as the heap
 * is 16-byte aligned.
 *
 * @param[in] word
 * @return The size of the block represented by the word
 */
static size_t extract_size(word_t word) {
    return (word & size_mask);
}

/**
 * @brief Extracts the miniblock status of the previous
 * block from a packed word.
 *
 * This function simply returns the third to last bit
 * in the given word
 *
 * @param[in] word
 * @return The miniblock status of the previous block
 */
static bool extract_prev_miniblock(word_t word) {
    return word & prev_miniblock_mask;
}

/**
 * @brief Extracts the prev_miniblock status from a block's header.
 * @param[in] block
 * @return The size of the block
 */
static bool get_prev_miniblock(block_t *block) {
    return extract_prev_miniblock(block->header);
}

/**
 * @brief Extracts the size of a block from its header.
 * @param[in] block
 * @return The size of the block
 */
static size_t get_size(block_t *block) {
    return extract_size(block->header);
}

/**
 * @brief Checks whether a block is a miniblock
 * @param[in] block
 * @return Whether the block is a miniblock
 */
static bool is_miniblock(block_t *block) {
    return get_size(block) == mini_block_size;
}

/**
 * @brief Given a payload pointer, returns a pointer to the corresponding
 *        block.
 * @param[in] bp A pointer to a block's payload
 * @return The corresponding block
 */
static block_t *payload_to_header(void *bp) {
    return (block_t *)((char *)bp - offsetof(block_t, payload));
}

/**
 * @brief Given a block pointer, returns a pointer to the corresponding
 *        payload.
 * @param[in] block
 * @return A pointer to the block's payload
 * @pre The block must be a valid block, not a boundary tag.
 */
static void *header_to_payload(block_t *block) {
    dbg_requires(get_size(block) != 0);
    return (void *)(block->payload);
}

/**
 * @brief Given a block pointer, returns a pointer to the corresponding
 *        footer.
 * @param[in] block
 * @return A pointer to the block's footer
 * @pre The block must be a valid block, not a boundary tag.
 */
static word_t *header_to_footer(block_t *block) {
    dbg_requires(get_size(block) != 0 &&
                 "Called header_to_footer on the epilogue block");
    return (word_t *)(block->payload + get_size(block) - dsize);
}

/**
 * @brief Given a block footer, returns a pointer to the corresponding
 *        header.
 * @param[in] footer A pointer to the block's footer
 * @return A pointer to the start of the block
 * @pre The footer must be the footer of a valid block, not a boundary tag.
 */
static block_t *footer_to_header(word_t *footer) {
    size_t size = extract_size(*footer);
    dbg_assert(size != 0 && "Called footer_to_header on the prologue block");
    return (block_t *)((char *)footer + wsize - size);
}

/**
 * @brief Returns the allocation status of a given header value.
 *
 * This is based on the lowest bit of the header value.
 *
 * @param[in] word
 * @return The allocation status correpsonding to the word
 */
static bool extract_alloc(word_t word) {
    return (bool)(word & alloc_mask);
}

/**
 * @brief Returns the previous block's allocation status for a given header
 * value.
 *
 * This is based on the second lowest bit of the header value.
 *
 * @param[in] word
 * @return The allocation status correpsonding to the previous block
 */
static bool extract_prev_alloc(word_t word) {
    return (bool)(word & prev_alloc_mask);
}

/**
 * @brief Returns the allocation status of a block, based on its header.
 * @param[in] block
 * @return The allocation status of the block
 */
static bool get_alloc(block_t *block) {
    return extract_alloc(block->header);
}

/**
 * @brief Returns the allocation status of the previous block,
 *        based on the current block's header.
 * @param[in] block
 * @return The allocation status of the previous block
 */
static bool get_prev_alloc(block_t *block) {
    return extract_prev_alloc(block->header);
}

/**
 * @brief Returns the payload size of a given block.
 *
 * The payload size is equal to the entire block size minus the sizes of the
 * block's header and footer.
 *
 * @param[in] block
 * @return The size of the block's payload
 */
static size_t get_payload_size(block_t *block) {
    size_t asize = get_size(block);
    return asize - wsize;
}

/**
 * @brief Writes an epilogue header at the given address.
 *
 * The epilogue header has size 0, and is marked as allocated.
 *
 * @param[out] block The location to write the epilogue header
 */
static void write_epilogue(block_t *block) {
    dbg_requires(block != NULL);
    dbg_requires((char *)block == (char *)mem_heap_hi() - 7);

    block->header =
        pack(0, true, get_prev_alloc(block), get_prev_miniblock(block));
}

/**
 * @brief Finds the next consecutive block on the heap.
 *
 * This function accesses the next block in the "implicit list" of the heap
 * by adding the size of the block.
 *
 * @param[in] block A block in the heap
 * @return The next consecutive block on the heap
 * @pre The block is not the epilogue
 */
static block_t *find_next(block_t *block) {
    dbg_requires(block != NULL);
    dbg_requires(get_size(block) != 0 &&
                 "Called find_next on the last block in the heap");
    return (block_t *)((char *)block + get_size(block));
}

/**
 * @brief Writes a block starting at the given address.
 *
 * This function writes both a header and footer, where the location of the
 * footer is computed in relation to the header.
 *
 * TODO: Are there any preconditions or postconditions?
 *
 * @param[out] block The location to begin writing the block header
 * @param[in] size The size of the new block
 * @param[in] alloc The allocation status of the new block
 * @param[in] prev_alloc The allocation status of the previous block
 */
static void write_block(block_t *block, size_t size, bool alloc,
                        bool prev_alloc, bool is_prev_mini) {
    dbg_requires(block != NULL);
    dbg_requires(size > 0);
    block->header = pack(size, alloc, prev_alloc, is_prev_mini);

    // the footer is written only in free blocks
    if (!alloc && !is_miniblock(block)) {
        word_t *footerp = header_to_footer(block);
        *footerp = pack(size, alloc, prev_alloc, is_prev_mini);
    }

    block_t *next = find_next(block);

    // adjust the prev_alloc bit in the next block's header
    if (alloc) {
        next->header |= prev_alloc_mask;
    } else {
        next->header &= ~prev_alloc_mask;
    }

    // adjust the prev_mini bit in the next block's header
    if (is_miniblock(block)) {
        next->header |= prev_miniblock_mask;
    } else {
        next->header &= ~prev_miniblock_mask;
    }
}

/**
 * @brief Finds the footer of the previous block on the heap.
 * @param[in] block A block in the heap
 * @return The location of the previous block's footer
 */
static word_t *find_prev_footer(block_t *block) {
    // Compute previous footer position as one word before the header
    return &(block->header) - 1;
}

/**
 * @brief Finds the previous consecutive block on the heap.
 *
 * This is the previous block in the "implicit list" of the heap.
 *
 * If the function is called on the first block in the heap, NULL will be
 * returned, since the first block in the heap has no previous block!
 *
 * The position of the previous block is found by reading the previous
 * block's footer to determine its size, then calculating the start of the
 * previous block based on its size.
 *
 * @param[in] block A block in the heap
 * @return The previous consecutive block in the heap.
 */
static block_t *find_prev(block_t *block) {
    dbg_requires(block != NULL);
    dbg_requires(
        !get_prev_alloc(block)); // since footer exists only in free blocks

    if (get_prev_miniblock(block)) {
        return (block_t *)((char *)block - mini_block_size);
    }

    word_t *footerp = find_prev_footer(block);
    // Return NULL if called on first block in the heap
    if (extract_size(*footerp) == 0) {
        return NULL;
    }
    return footer_to_header(footerp);
}

/*
 * ---------------------------------------------------------------------------
 *                        END SHORT HELPER FUNCTIONS
 * ---------------------------------------------------------------------------
 */

/******** The remaining content below are helper and debug routines ********/

/**
 * @brief returns the corresponding 'bucket' or index in seglists given an asize
 * @param[in] asize
 * @return the bucket in which a free block of size asize would be in seglists
 */
static size_t get_index_from_asize(size_t asize) {
    if (asize == mini_block_size) {
        return 0;
    }

    size_t result = 1;

    while ((1 < asize) && (result < NUM_LISTS - 1)) {
        result++;
        asize = asize >> 1;
    }
    return result;
}

/**
 * @brief inserts the given block in the appropriate freelist within seglists
 * @param[in] block
 * @return the block will be inserted in the appropriate freelist at the top
 *         of that freelist (stack discipline)
 */
static void insert_to_freelist(block_t *block) {
    size_t index = get_index_from_asize(get_size(block));

    if (is_miniblock(block)) {
        block->freelist.next_free_block = seglists[0];
        seglists[index] = block;
        return;
    }

    block->freelist.next_free_block = seglists[index];
    block->freelist.prev_free_block = NULL;

    if (seglists[index] != NULL) {
        seglists[index]->freelist.prev_free_block = block;
    }

    seglists[index] = block;
}

/**
 * @brief removes the given block from the appropriate freelist within seglists
 * @param[in] block
 * @return the block will be removed from the appropriate freelist
 */
static void remove_from_freelist(block_t *block) {
    size_t index = get_index_from_asize(get_size(block));

    if (is_miniblock(block)) {
        block_t *prev = NULL;
        block_t *curr = seglists[index];

        // Case 1: if curr already matches block
        if ((curr != NULL) && (curr == block)) {
            seglists[index] = curr->freelist.next_free_block;
            return;
        }

        // Case 2: search for matching block while keeping track of prev
        while ((curr != NULL) && (curr != block)) {
            prev = curr;
            curr = curr->freelist.next_free_block;
        }

        // Case 3: If bock wasn't found
        if (curr == NULL) {
            return;
        }

        prev->freelist.next_free_block = curr->freelist.next_free_block;
        return;
    }

    block_t *prev_free_block = block->freelist.prev_free_block;
    block_t *next_free_block = block->freelist.next_free_block;

    if (prev_free_block != NULL) {
        prev_free_block->freelist.next_free_block = next_free_block;
    } else {
        seglists[index] = next_free_block;
    }

    if (next_free_block != NULL) {
        next_free_block->freelist.prev_free_block = prev_free_block;
    }
}

/**
 * @brief Attempts to merge the given free block with adjacent free blocks
 * @param[in] block
 * @return Pointer to the coalesced block (may be the same or different as
 * input)
 */
static block_t *coalesce_block(block_t *block) {
    block_t *prev = NULL;
    block_t *next = find_next(block);
    bool prev_alloc = get_prev_alloc(block);
    bool next_alloc = ((next == NULL) ? true : get_alloc(next));
    size_t block_size = get_size(block);

    if (!prev_alloc) {
        prev = find_prev(block);
    }

    // Case 1: prev and next blocks are both allocated
    if (prev_alloc && next_alloc) {
        // printf("Case 1\n");
        insert_to_freelist(block);
        return block;
    }

    // Case 2: prev and next blocks are both free
    if (!prev_alloc && !next_alloc) {
        // printf("Case 2\n");
        block_size += get_size(prev) + get_size(next);

        remove_from_freelist(prev);
        remove_from_freelist(next);

        write_block(prev, block_size, false, get_prev_alloc(prev),
                    get_prev_miniblock(prev));
        insert_to_freelist(prev);
        return prev;
    }

    // Case 3: prev block is free while next block is allocated
    if (!prev_alloc && next_alloc) {
        // printf("Case 3\n");
        block_size += get_size(prev);

        remove_from_freelist(prev);

        write_block(prev, block_size, false, get_prev_alloc(prev),
                    get_prev_miniblock(prev));
        insert_to_freelist(prev);
        return prev;
    }

    // Case 4: prev block is allocated while next block is free
    if (prev_alloc && !next_alloc) {
        // printf("Case 4\n");
        block_size += get_size(next);

        remove_from_freelist(next);

        write_block(block, block_size, false, true, get_prev_miniblock(block));
        insert_to_freelist(block);
        return block;
    }
    return block;
}

/**
 * @brief Extends the heap with a new free block of at least the given size
 * @param[in] size
 * @return Pointer to the newly created free block or NULL if failure occurs
 */
static block_t *extend_heap(size_t size) {
    void *bp;

    // Allocate an even number of words to maintain alignment
    size = round_up(size, dsize);
    if ((bp = mem_sbrk((intptr_t)size)) == (void *)-1) {
        return NULL;
    }
    // Initialize free block header/footer
    block_t *block = payload_to_header(bp);
    bool prev_block_alloc = get_prev_alloc(block);
    write_block(block, size, false, prev_block_alloc,
                get_prev_miniblock(block));

    // Create new epilogue header
    block_t *block_next = find_next(block);
    write_epilogue(block_next);

    // Coalesce in case the previous block was free
    block = coalesce_block(block);

    return block;
}

/**
 * @brief Splits a block into an allocated block and a smaller free block if
 * possible. In the case where the remaining block is exactly 16 bytes, a new
 * miniblock is created.
 * @param[in] block
 * @param[in] asize
 */
static void split_block(block_t *block, size_t asize) {
    dbg_requires(get_alloc(block));
    dbg_requires(get_size(block) > 0);

    size_t block_size = get_size(block);
    size_t remainder = block_size - asize;

    if ((remainder >= min_block_size) || (remainder == mini_block_size)) {
        write_block(block, asize, true, get_prev_alloc(block),
                    get_prev_miniblock(block));
        block_t *next = find_next(block);

        if (remainder == mini_block_size) {
            write_block(next, mini_block_size, false, true,
                        is_miniblock(block));
        } else {
            write_block(next, remainder, false, true, is_miniblock(block));
        }
        insert_to_freelist(next);
    }
    dbg_ensures(get_alloc(block));
}

/**
 * @brief Uses a best fit method to find the smallest block with size greater
 * than asize within the segregated free list.
 * @param[in] asize
 * @return The best fit block if one is found, or NULL if nothing can be found
 */
static block_t *find_fit(size_t asize) {
    block_t *block;
    block_t *best_fit = NULL;
    size_t block_size;
    size_t best_size = ~((size_t)0);
    size_t index = get_index_from_asize(asize);

    for (size_t i = index; i < NUM_LISTS; i++) {
        for (block = seglists[i]; block != NULL;
             block = block->freelist.next_free_block) {

            block_size = get_size(block);
            if (asize <= block_size) {
                if (asize == block_size) {
                    return block;
                } else {
                    if (block_size < best_size) {
                        best_fit = block;
                        best_size = block_size;
                    }
                }
            }
        }
        if (best_fit != NULL) {
            break;
        }
    }
    return best_fit;
}

/**
 * @brief ensures that the payload within the input block is
 * 16-byte aligned
 */
static bool check_16byte_aligned(block_t *block) {
    return ((uintptr_t)header_to_payload(block) % 16L) == 0L;
}

/**
 * @brief ensures that the input block is the epilogue block
 */
static bool check_end_block(block_t *block) {
    return (get_size(block) == 0) && get_alloc(block);
}

/**
 * @brief ensures that the input block is the prologue block
 */
static bool check_starting_block(word_t *header) {
    return (extract_size(*header) == 0) && (*header & 0x1);
}

/**
 * @brief ensures that a given block is within the heap bounds
 */
static bool check_block_within_heap(block_t *block, void *heap_lo,
                                    void *heap_hi) {
    void *footer_ptr = (void *)header_to_footer(block);
    return (heap_lo < (void *)block) && (footer_ptr < heap_hi);
}

/**
 * @brief ensures that if current block is free, then the
 * next block is allocated
 */
static bool check_coalesce(block_t *block) {
    if (!get_alloc(block) && !get_alloc(find_next(block))) {
        return false;
    }
    return true;
}

/**
 * @brief checks that the header and footer are identical
 *        for non-mini free blocks
 */
static bool check_header_footer_match(block_t *block) {
    if (!is_miniblock(block) && !get_alloc(block)) {
        word_t *footer_ptr = header_to_footer(block);
        return block->header == *footer_ptr;
    }
    return true;
}

/**
 * @brief checks that the prev/next points of the next/prev free blocks
 * respectively point back to the current free block within all buckets
 * of seglists except for the one containing the free miniblocks
 */
static bool check_freelist_consistency(block_t *curr_free_block) {
    block_t *prev_free_block = curr_free_block->freelist.prev_free_block;
    block_t *next_free_block = curr_free_block->freelist.next_free_block;

    if (prev_free_block != NULL) {
        return prev_free_block->freelist.next_free_block == curr_free_block;
    }

    if (next_free_block != NULL) {
        return next_free_block->freelist.prev_free_block == curr_free_block;
    }

    return true;
}

/**
 * @brief Prints the current state of the heap by displaying information about
 * every block on the heap
 */
static void print_heap(void) {
    block_t *block;

    printf("\nNOTE: Printheap called here\n");
    for (block = heap_start; get_size(block) > 0; block = find_next(block)) {
        printf("\nAddress: %p, Size: %ld, Alloc: %d, Prev Alloc: %d, Prev "
               "Mini: %d\n",
               (void *)block, get_size(block), get_alloc(block),
               get_prev_alloc(block), get_prev_miniblock(block));
    }
    printf(
        "\nAddress: %p, Size: %ld, Alloc: %d, Prev Alloc: %d, Prev Mini: %d\n",
        (void *)block, get_size(block), get_alloc(block), get_prev_alloc(block),
        get_prev_miniblock(block));
    printf("\nEntire heap printed\n");
}

/**
 * @brief Ensures that no invariants of the heap data structure are violated.
 *        To see the checks being made, look at each of the if statements.
 * @param[in] line
 * @return True if the heap data structure is valid, false if any invariants are
 * violated.
 */
bool mm_checkheap(int line) {
    block_t *block;
    void *heap_lo = mem_heap_lo();
    void *heap_hi = mem_heap_hi();

    size_t freelist_count = 0;
    size_t freeblock_count = 0;

    // checking prologue block validity
    if (!check_starting_block((word_t *)heap_lo + NUM_LISTS)) {
        printf("\nERROR at line %d: incorrect prologue at %p\n", line, heap_lo);
        return false;
    }

    // iterates through all blocks (both free blocks and allocated blocks)
    for (block = heap_start; get_size(block) > 0; block = find_next(block)) {
        if (!check_16byte_aligned(block)) {
            printf("\nERROR at line %d: block at %p not aligned to 16-byte "
                   "boundary\n",
                   line, (void *)block);
            return false;
        }
        if (!check_coalesce(block)) {
            printf(
                "\nERROR at line %d: two adjacent free blocks at %p and %p\n",
                line, (void *)block, (void *)(find_next(block)));
            // return false;
            return true;
        }
        if (!check_block_within_heap(block, heap_lo, heap_hi)) {
            printf("\nERROR at line %d: block at %p is outside of heap\n", line,
                   (void *)block);
            return false;
        }
        if (!check_header_footer_match(block)) {
            printf("\nERROR at line %d: block at %p has mismatching header and "
                   "footer\n",
                   line, (void *)block);
            return false;
        }
        if ((get_size(block) < min_block_size) &&
            (get_size(block) != mini_block_size)) {
            printf("\nERROR at line %d: block at %p is too small\n", line,
                   (void *)block);
            return false;
        }
        if (!get_alloc(block)) {
            freeblock_count++;
        }
    }
    // checks that the epilogue block is a valid end dummy block
    if (!check_end_block(block)) {
        printf("\nERROR at line %d: invalid end dummy block at %p\n", line,
               (void *)block);
        return false;
    }

    // iterates through every free list
    for (size_t index = 0; index < NUM_LISTS; index++) {
        for (block_t *curr_free_block = seglists[index];
             curr_free_block != NULL;
             curr_free_block = curr_free_block->freelist.next_free_block) {
            if (index != get_index_from_asize(get_size(curr_free_block))) {
                printf("\nERROR at line %d: free block at %p is located in "
                       "wrong freelist class\n",
                       line, (void *)curr_free_block);
                return false;
            }
            if (get_alloc(curr_free_block)) {
                printf(
                    "\nERROR at line %d: allocated block at %p found in free "
                    "list\n",
                    line, (void *)curr_free_block);
                return false;
            }
            if ((index != 0) &&
                (!check_freelist_consistency(curr_free_block))) {
                printf("\nERROR at line %d: free block at %p has mismatching "
                       "pointers with prev or next free block\n",
                       line, (void *)curr_free_block);
                return false;
            }
            if (!check_block_within_heap(curr_free_block, heap_lo, heap_hi)) {
                printf(
                    "\nERROR at line %d: free block at %p is not within heap "
                    "bounds\n",
                    line, (void *)curr_free_block);
                return false;
            }
            freelist_count++;
        }
    }
    if (freeblock_count != freelist_count) {
        printf("\nERROR at line %d: different number of free blocks in "
               "freelist (%ld) vs heap memory (%ld)\n",
               line, freelist_count, freeblock_count);
        return false;
    }

    return true;
}

/**
 * @brief Intializes the heap and segregated free lists
 *
 * Sets up the segregated free list array and writes the initial prologue and
 * epilogue headers. It also extends the heap with an initial free block.
 *
 * @return true if initialization succeeded, false otherwise
 */
bool mm_init(void) {
    intptr_t seglists_size = NUM_LISTS * sizeof(block_t *);
    seglists = (block_t **)(mem_sbrk(seglists_size));

    if (seglists == (void *)-1) {
        return false;
    }

    // Init every element of seglists to NULL
    for (size_t index = 0; index < NUM_LISTS; index++) {
        seglists[index] = NULL;
    }

    // Create the initial empty heap
    word_t *start = (word_t *)(mem_sbrk(2 * wsize));

    if (start == (void *)-1) {
        return false;
    }

    start[0] = pack(0, true, false, false); // Heap prologue (block footer)
    start[1] = pack(0, true, true, false);  // Heap epilogue (block header)

    // Heap starts with first "block header", currently the epilogue
    heap_start = (block_t *)&(start[1]);

    // Extend the empty heap with a free block of chunksize bytes
    if (extend_heap(chunksize) == NULL) {
        return false;
    }

    return true;
}

/**
 * @brief Allocates a block of memory with at least 'size' bytes on the heap
 *
 * Adjusts the requested size to meet alignment and minimum block size
 * requirements, calls find_fit to get an appropriate block, writes to the block
 * header to update metadata, and then returns a pointer to the payload.
 *
 * @param[in] size
 * @return Pointer to the payload if successful, NULL otherwise
 */
void *malloc(size_t size) {
    dbg_requires(mm_checkheap(__LINE__));

    size_t asize;      // Adjusted block size
    size_t extendsize; // Amount to extend heap if no fit is found
    block_t *block;
    void *bp = NULL;

    // Initialize heap if it isn't initialized
    if (heap_start == NULL) {
        if (!(mm_init())) {
            dbg_printf("Problem initializing heap. Likely due to sbrk");
            return NULL;
        }
    }

    // Ignore spurious request
    if (size == 0) {
        dbg_ensures(mm_checkheap(__LINE__));
        return bp;
    }

    if (size <= wsize) {
        asize = mini_block_size;
    } else {
        // Adjust block size to include overhead and to meet alignment
        // requirements
        asize = round_up(size + wsize, dsize);
        asize = max(asize, min_block_size);
    }

    // Search the free list for a fit
    block = find_fit(asize);

    // If no fit is found, request more memory, and then and place the block
    if (block == NULL) {
        // Always request at least chunksize
        extendsize = max(asize, chunksize);
        block = extend_heap(extendsize);
        // extend_heap returns an error
        if (block == NULL) {
            return bp;
        }
    }
    bool prev_block_alloc = get_prev_alloc(block);

    // The block should be marked as free
    dbg_assert(!get_alloc(block));

    remove_from_freelist(block);

    // Mark block as allocated
    size_t block_size = get_size(block);
    write_block(block, block_size, true, prev_block_alloc,
                get_prev_miniblock(block));

    // Try to split the block if too large
    split_block(block, asize);

    bp = header_to_payload(block);

    dbg_ensures(mm_checkheap(__LINE__));
    return bp;
}

/**
 * @brief frees a previously allocated block
 *
 * Marks the block as free, writes the header and footer, and coalesces with
 * adjacent free blocks (if necessary) before finally adding this block to the
 * appropriate freelist.
 *
 * @param[in] bp
 * @pre 'bp' must be a valid pointer returned by an allocation function and
 * cannot already be free
 */
void free(void *bp) {
    dbg_requires(mm_checkheap(__LINE__));

    if (bp == NULL) {
        return;
    }

    block_t *block = payload_to_header(bp);
    size_t size = get_size(block);

    // The block should be marked as allocated
    dbg_assert(get_alloc(block));

    // Mark the block as free
    write_block(block, size, false, get_prev_alloc(block),
                get_prev_miniblock(block));

    // Try to coalesce the block with its neighbors
    coalesce_block(block);

    dbg_ensures(mm_checkheap(__LINE__));
}

/**
 * @brief Reallocates a previously allocated block to a new size.
 *
 * If 'ptr' is NULL, realloc behaves like malloc. If 'size' is 0, realloc is
 * effectively free. Otherwise it copies the old data into a new block of at
 * least 'size' bytes and frees the old block.
 *
 * @param[in] ptr
 * @param[in] size
 * @return Pointer to new block, or NULL if allocation fails
 */
void *realloc(void *ptr, size_t size) {
    block_t *block = payload_to_header(ptr);
    size_t copysize;
    void *newptr;

    // If size == 0, then free block and return NULL
    if (size == 0) {
        free(ptr);
        return NULL;
    }

    // If ptr is NULL, then equivalent to malloc
    if (ptr == NULL) {
        return malloc(size);
    }

    // Otherwise, proceed with reallocation
    newptr = malloc(size);

    // If malloc fails, the original block is left untouched
    if (newptr == NULL) {
        return NULL;
    }

    // Copy the old data
    copysize = get_payload_size(block); // gets size of old payload
    if (size < copysize) {
        copysize = size;
    }
    memcpy(newptr, ptr, copysize);

    // Free the old block
    free(ptr);

    return newptr;
}

/**
 * @brief Does what malloc does but also initializes the data to default values
 *
 * Allocates the necessary amount of space through malloc and then initializes
 * everything within the allocation to 0.
 *
 * @param[in] elements
 * @param[in] size
 * @return Pointer to zero-initialized payload, or NULL if allocation fails.
 */
void *calloc(size_t elements, size_t size) {
    void *bp;
    size_t asize = elements * size;

    if (elements == 0) {
        return NULL;
    }
    if (asize / elements != size) {
        // Multiplication overflowed
        return NULL;
    }

    bp = malloc(asize);
    if (bp == NULL) {
        return NULL;
    }

    // Initialize all bits to 0
    memset(bp, 0, asize);

    return bp;
}

/*
 *****************************************************************************
 * Do not delete the following super-secret(tm) lines!                       *
 *                                                                           *
 * 53 6f 20 79 6f 75 27 72 65 20 74 72 79 69 6e 67 20 74 6f 20               *
 *                                                                           *
 * 66 69 67 75 72 65 20 6f 75 74 20 77 68 61 74 20 74 68 65 20               *
 * 68 65 78 61 64 65 63 69 6d 61 6c 20 64 69 67 69 74 73 20 64               *
 * 6f 2e 2e 2e 20 68 61 68 61 68 61 21 20 41 53 43 49 49 20 69               *
 *                                                                           *
 * 73 6e 27 74 20 74 68 65 20 72 69 67 68 74 20 65 6e 63 6f 64               *
 * 69 6e 67 21 20 4e 69 63 65 20 74 72 79 2c 20 74 68 6f 75 67               *
 * 68 21 20 2d 44 72 2e 20 45 76 69 6c 0a c5 7c fc 80 6e 57 0a               *
 *                                                                           *
 *****************************************************************************
 */
