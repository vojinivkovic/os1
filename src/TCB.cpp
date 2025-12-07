//
// Created by os on 12/5/25.
//

#include "../h/TCB.hpp"
void TCB::initializeThread(TCB::Body function, void *allocatedStack, ObjectPool<TCB, NUM_OF_THREADS_IN_POOL> *pool)
{
    body = function;
    stack = allocatedStack;
    timeSlice = DEFAULT_TIME_SLICE;
    state = nullptr;
    isFinished = false;
    size_t sizeOfStack = sizeof(uint64) * DEFAULT_SYSTEM_STACK_SIZE / MEM_BLOCK_SIZE;
    sizeOfStack += sizeOfStack % MEM_BLOCK_SIZE ? 1 : 0;
    systemStack = (uint64*)MemoryAllocator::allocateMemory(sizeOfStack);
    context = {(uint64) &body, (uint64) &allocatedStack[DEFAULT_STACK_SIZE], (uint64) &systemStack[DEFAULT_SYSTEM_STACK_SIZE]};
}