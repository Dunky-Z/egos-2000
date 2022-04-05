/*
 * (C) 2022, Cornell University
 * All rights reserved.
 */

/* Author: Yunhao Zhang
 * Description: naive malloc() and free(); 
 * A better one is left to students as an exercise
 */

#include "egos.h"

/* heap region is defined in the memory layout scripts */
extern char __heap_start, __heap_end;
static char* brk = &__heap_start;

void* my_alloc(unsigned int size) {
    if (brk + size >= &__heap_end) FATAL("Heap is full");

    char* old_brk = brk;
    brk += size;
    return old_brk;
}

void my_free(void* ptr) {}