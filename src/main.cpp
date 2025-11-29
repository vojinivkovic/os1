//
// Created by os on 11/29/25.
//
#include "../h/MemoryAllocator.hpp"
void main(){
    //void* allocMem1 = (void*)MemoryAllocator::allocateMemory(4);
    void* allocMem1 = MemoryAllocator::allocateMemory(4);
    void* allocMem2 = MemoryAllocator::allocateMemory(10);
    MemoryAllocator::freeMemory(allocMem1);
    MemoryAllocator::freeMemory(allocMem2);
    MemoryAllocator::allocateMemory(4);
}