// mm.c - Modified to use segregated free lists

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

#ifdef DRIVER
#define malloc mm_malloc
#define free mm_free
#define realloc mm_realloc
#define calloc mm_calloc
#define memset mem_memset
#define memcpy mem_memcpy
#endif

/* Basic constants and macros */
typedef uint64_t word_t;
static const size_t wsize = sizeof(word_t);
static const size_t dsize = 2 * wsize;
static const size_t min_block_size = 2 * dsize;
static const size_t chunksize = (1 << 12);
static const word_t alloc_mask = 0x1;
static const word_t size_mask = ~(word_t)0xF;

#define LISTLIMIT 20

/* Block structure */
typedef struct block {
    word_t header;
    union {
        struct {
            struct block *prev_free_block;
            struct block *next_free_block;
        } freelist;
        char payload[0];
    };
} block_t;

static block_t *heap_start = NULL;
static block_t *seg_lists[LISTLIMIT];

static size_t max(size_t x, size_t y) {return (x > y) ? x : y; }
static size_t pack(size_t size, bool alloc) { return size | alloc; }
static size_t extract_size(word_t word) { return word & size_mask; }
static bool extract_alloc(word_t word) { return word & alloc_mask; }
static size_t get_size(block_t *b) { return extract_size(b->header); }
static bool get_alloc(block_t *b) { return extract_alloc(b->header); }
static void *header_to_payload(block_t *b) { return (void *)(b->payload); }
static block_t *payload_to_header(void *p) { return (block_t *)((char *)p - offsetof(block_t, payload)); }
static word_t *header_to_footer(block_t *b) { return (word_t *)((char *)b + get_size(b) - wsize); }
static block_t *footer_to_header(word_t *f) { return (block_t *)((char *)f + wsize - extract_size(*f)); }
static block_t *find_next(block_t *b) { return (block_t *)((char *)b + get_size(b)); }
static word_t *find_prev_footer(block_t *b) { return &b->header - 1; }
static block_t *find_prev(block_t *b) {
    word_t *f = find_prev_footer(b);
    return extract_size(*f) == 0 ? NULL : footer_to_header(f);
}
static size_t round_up(size_t size, size_t mult) { return ((size + mult - 1) / mult) * mult; }

static void write_block(block_t *b, size_t size, bool alloc) {
    b->header = pack(size, alloc);
    word_t *footer = header_to_footer(b);
    *footer = pack(size, alloc);
}

static void write_epilogue(block_t *b) { b->header = pack(0, true); }

static int get_list_index(size_t size) {
    int idx = 0;
    while ((idx < LISTLIMIT - 1) && (size > 1)) {
        size >>= 1;
        idx++;
    }
    return idx;
}

static void insert_to_freelist(block_t *block) {
    int idx = get_list_index(get_size(block));
    block->freelist.next_free_block = seg_lists[idx];
    block->freelist.prev_free_block = NULL;
    if (seg_lists[idx]) {
        seg_lists[idx]->freelist.prev_free_block = block;
    }
    seg_lists[idx] = block;
}

static void remove_from_freelist(block_t *block) {
    int idx = get_list_index(get_size(block));
    block_t *prev = block->freelist.prev_free_block;
    block_t *next = block->freelist.next_free_block;
    if (prev) prev->freelist.next_free_block = next;
    else seg_lists[idx] = next;
    if (next) next->freelist.prev_free_block = prev;
    block->freelist.next_free_block = NULL;
    block->freelist.prev_free_block = NULL;
}

static block_t *coalesce_block(block_t *b) {
    block_t *prev = find_prev(b);
    block_t *next = find_next(b);
    bool prev_alloc = prev == NULL || get_alloc(prev);
    bool next_alloc = get_size(next) == 0 || get_alloc(next);
    size_t size = get_size(b);

    if (!prev_alloc && !next_alloc) {
        size += get_size(prev) + get_size(next);
        remove_from_freelist(prev);
        remove_from_freelist(next);
        write_block(prev, size, false);
        insert_to_freelist(prev);
        return prev;
    } else if (!prev_alloc) {
        size += get_size(prev);
        remove_from_freelist(prev);
        write_block(prev, size, false);
        insert_to_freelist(prev);
        return prev;
    } else if (!next_alloc) {
        size += get_size(next);
        remove_from_freelist(next);
        write_block(b, size, false);
        insert_to_freelist(b);
        return b;
    } else {
        write_block(b, size, false);
        insert_to_freelist(b);
        return b;
    }
}

static block_t *extend_heap(size_t size) {
    size = round_up(size, dsize);
    void *bp = mem_sbrk((intptr_t)size);
    if (bp == (void *)-1) return NULL;
    block_t *block = payload_to_header(bp);
    write_block(block, size, false);
    block_t *epilogue = find_next(block);
    write_epilogue(epilogue);
    return coalesce_block(block);
}

static void split_block(block_t *block, size_t asize) {
    size_t bsize = get_size(block);
    if ((bsize - asize) >= min_block_size) {
        write_block(block, asize, true);
        block_t *next = find_next(block);
        write_block(next, bsize - asize, false);
        insert_to_freelist(next);
    }
}

static block_t *find_fit(size_t asize) {
    int idx = get_list_index(asize);
    for (int i = idx; i < LISTLIMIT; i++) {
        block_t *block = seg_lists[i];
        while (block) {
            if (get_size(block) >= asize) {
                return block;
            }
            block = block->freelist.next_free_block;
        }
    }
    return NULL;
}

bool mm_init(void) {
    word_t *start = mem_sbrk(2 * wsize);
    if (start == (void *)-1) return false;
    start[0] = pack(0, true);
    start[1] = pack(0, true);
    heap_start = (block_t *)&start[1];
    for (int i = 0; i < LISTLIMIT; i++) seg_lists[i] = NULL;
    return extend_heap(chunksize) != NULL;
}

void *malloc(size_t size) {
    if (heap_start == NULL && !mm_init()) return NULL;
    if (size == 0) return NULL;
    size_t asize = round_up(size + dsize, dsize);
    block_t *block = find_fit(asize);
    if (block == NULL) {
        block = extend_heap((size_t)max(asize, chunksize));
        if (block == NULL) return NULL;
    }
    remove_from_freelist(block);
    write_block(block, get_size(block), true);
    split_block(block, asize);
    return header_to_payload(block);
}

void free(void *ptr) {
    if (ptr == NULL) return;
    block_t *block = payload_to_header(ptr);
    write_block(block, get_size(block), false);
    coalesce_block(block);
}

void *realloc(void *ptr, size_t size) {
    if (ptr == NULL) return malloc(size);
    if (size == 0) {
        free(ptr);
        return NULL;
    }
    void *newptr = malloc(size);
    if (!newptr) return NULL;
    block_t *old_block = payload_to_header(ptr);
    size_t old_size = get_size(old_block) - dsize;
    if (size < old_size) old_size = size;
    memcpy(newptr, ptr, old_size);
    free(ptr);
    return newptr;
}

void *calloc(size_t nmemb, size_t size) {
    size_t bytes = nmemb * size;
    if (nmemb == 0 || size == 0 || bytes / nmemb != size) return NULL;
    void *ptr = malloc(bytes);
    if (ptr) memset(ptr, 0, bytes);
    return ptr;
}

bool mm_checkheap(int line) {
    printf("I did not write a heap checker (called at line %d)\n", line);
    return true;
}
