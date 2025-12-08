//
// Created by os on 12/5/25.
//

#include "../h/TCB.hpp"
const size_t TCB::DEFAULT_SYSTEM_STACK_SIZE = 1024;
size_t TCB::numOfTicks = 0;
void TCB::initializeThread(TCB::Body function, void*arg, void *allocatedStack)
{
    body = function;
    stack = (uint64*)allocatedStack;
    timeSlice = DEFAULT_TIME_SLICE;
    state = nullptr;
    isFinished = false;
    arguments = arg;
    size_t sizeOfStack = sizeof(uint64) * DEFAULT_SYSTEM_STACK_SIZE / MEM_BLOCK_SIZE;
    sizeOfStack += sizeOfStack % MEM_BLOCK_SIZE ? 1 : 0;
    systemStack = (uint64*)MemoryAllocator::allocateMemory(sizeOfStack);

    context = {(uint64) &threadWrapper, (uint64) &stack[DEFAULT_STACK_SIZE], (uint64) &systemStack[DEFAULT_SYSTEM_STACK_SIZE]};
    Scheduler::put(this);
}
