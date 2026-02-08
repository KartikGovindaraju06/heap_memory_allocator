# Malloc Lab Allocator (mm.c)

This README describes the allocator implementation in `mm.c`.

## High-level design

- **Block format**: Each block stores a header with size, alloc bit, and two
  neighbor metadata bits: `prev_alloc` and `prev_miniblock`. Free blocks (except
  miniblocks) store a footer; allocated blocks are footerless to save space.
- **Miniblocks**: 16-byte blocks handle very small requests (<= 8 bytes). These
  are managed in a dedicated segregated list bucket and avoid footers.
- **Segregated free lists**: `NUM_LISTS` size classes by powers of two. Non-mini
  free blocks are doubly linked; miniblocks use a singly linked list.

## Allocation path

- **Size adjustment**: Requests are rounded for 16-byte alignment and minimum
  block size. Requests <= 8 bytes become a 16-byte miniblock.
- **Search policy**: Best-fit across the size class and larger classes to find
  the smallest suitable block.
- **Split policy**: Blocks are split when the remainder can form a normal free
  block or a miniblock. The remainder is inserted into the free lists.

## Free path

- **Coalescing**: On `free`, adjacent free blocks are merged. The allocator uses
  `prev_alloc` and `prev_miniblock` to avoid unnecessary footer lookups.
- **Free list maintenance**: Blocks are removed before modification and reinserted
  after coalescing. The list discipline is stack-style insertion.

## Heap growth and boundaries

- The heap starts with a prologue footer and an epilogue header.
- The heap extends in aligned chunks (`chunksize` or request size), then
  coalesces with the previous block if possible.

## Correctness checks

`mm_checkheap()` validates alignment, header/footer consistency (when present),
heap bounds, absence of adjacent free blocks, and free list consistency,
including free block count matching.
