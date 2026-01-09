//
// Created by os on 11/29/25.
//

#ifndef PROJECT_BASE_V1_1_MEMORYALLOCATOR_HPP
#define PROJECT_BASE_V1_1_MEMORYALLOCATOR_HPP

#include "../lib/hw.h"
#include "MetaData.hpp"

class MemoryAllocator
{
public:

    MemoryAllocator() = delete;
    MemoryAllocator(const MemoryAllocator& memAlloc) = delete; // copy-constructor is deleted; singleton pattern
    MemoryAllocator& operator=(const MemoryAllocator& memAlloc) = delete; // assignment operator is also deleted

    static void* allocateMemory(size_t blocksToAllocate);
    static int freeMemory(void* addressToFree);
    static size_t getLargestFreeBlock();
    static size_t getFreeSpace();
    static void initialize();

private:
    static FreeBlock* firstFreeBlock;
    static size_t numOfFreeBlocks;
    static size_t NUM_OF_BLOCKS;
    static void* findBestFit(FreeBlock** head, size_t blocksToAllocate);
    static void remapMemory(FreeBlock** head, FreeBlock* allocatedBlocks, size_t blocksToAllocate);
    static FreeBlock* findNextFreeBlock(FreeBlock* memoryToFree);
    static FreeBlock* findPreviousFreeBlock(FreeBlock* head, FreeBlock* memoryToFree);
    static void connectAdjacentBlocks(FreeBlock* previousBlock, FreeBlock* nextBlock);


};


#endif //PROJECT_BASE_V1_1_MEMORYALLOCATOR_HPP
