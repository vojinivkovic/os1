//
// Created by os on 11/29/25.
//
#include "../h/MemoryAllocator.hpp"
#include "../h/Kernel.hpp"
#include "../h/syscall_c.hpp"
void main(){

    void* allocMem1 = (void*)MemoryAllocator::allocateMemory(5);
    void* allocMem2 = (void*)MemoryAllocator::allocateMemory(10);
    void* allocMem3 = (void*)MemoryAllocator::allocateMemory(6);
    void* allocMem4 = (void*)MemoryAllocator::allocateMemory(15);
    void* allocMem5 = (void*)MemoryAllocator::allocateMemory(20);
    void* allocMem6 = (void*)MemoryAllocator::allocateMemory(30);
    void* allocMem7 = (void*)MemoryAllocator::allocateMemory(15);
    void* allocMem8 = (void*)MemoryAllocator::allocateMemory(7);
    void* allocMem9 = (void*)MemoryAllocator::allocateMemory(8);
    MemoryAllocator::freeMemory(allocMem2);
    MemoryAllocator::freeMemory(allocMem7);
    MemoryAllocator::freeMemory(allocMem8);
    MemoryAllocator::freeMemory(allocMem4);
    void* allocMem10 = (void*)MemoryAllocator::allocateMemory(9);
    void* allocMem11 = (void*)MemoryAllocator::allocateMemory(20);
    void* allocMem12 = (void*)MemoryAllocator::allocateMemory(30);
    void* allocMem13 = (void*)MemoryAllocator::allocateMemory(40);
    MemoryAllocator::freeMemory(allocMem11);
    MemoryAllocator::freeMemory(allocMem13);
    MemoryAllocator::freeMemory(allocMem3);
    MemoryAllocator::freeMemory(allocMem1);
    MemoryAllocator::freeMemory(allocMem10);
    MemoryAllocator::freeMemory(allocMem6);
    MemoryAllocator::freeMemory(allocMem9);
    MemoryAllocator::freeMemory(allocMem5);
    MemoryAllocator::freeMemory(allocMem12);

//    Kernel::initializeKernel();
////    __asm__ volatile ("ecall");
//    void* allocMem1 = mem_alloc(100);
//    mem_free(allocMem1);
//    void* allocMem2 = mem_alloc(10);
//    mem_free(allocMem2);
}