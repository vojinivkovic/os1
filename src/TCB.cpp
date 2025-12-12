//
// Created by os on 12/5/25.
//

#include "../h/TCB.hpp"
#include "../h/Scheduler.hpp"
#include "../h/syscall_c.hpp"

extern "C" void context_switch(TCB::Context* oldContext, TCB::Context* newContext);

size_t TCB::numOfTicks = 0;
TCB* TCB::running = nullptr;
void TCB::initializeThread(TCB::Body function, void*arg, void *allocatedStack, void* allocatedSystemStack, KernelConfig::Mode mode)
{

    body = function;
    timeSlice = DEFAULT_TIME_SLICE;
    state = nullptr;
    finished = false;
    arguments = arg;

    //size_t sizeOfStack = sizeof(uint8) * DEFAULT_SYSTEM_STACK_SIZE / MEM_BLOCK_SIZE;
    //sizeOfStack += sizeOfStack % MEM_BLOCK_SIZE ? 1 : 0;
    //systemStack = (uint64*)MemoryAllocator::allocateMemory(sizeOfStack);

    //size_t numOfElements = DEFAULT_SYSTEM_STACK_SIZE / 8;
    //systemStack[numOfElements - 30] = (uint64)allocatedStack;
     *((uint64*)allocatedSystemStack - 30) = (uint64)((uint64*)allocatedStack - 2);

    context = {Machine::readSscratch(), (uint64) ((uint64*)allocatedSystemStack - 32), mode};
    Machine::writeSepc((uint64)&threadWrapper);
    Scheduler::put(this);
}
void TCB::threadWrapper()
{
    running->body(running->arguments);
    thread_exit();

}
void TCB::yield(TCB *oldThread, TCB *newThread)
{
    context_switch(&(oldThread->context), &(newThread->context));
}

void TCB::dispatch()
{
    TCB* oldThread = running;
    if(!oldThread->isFinished)
    {
        Scheduler::put(oldThread);
    }
    running = Scheduler::get();
    yield(oldThread, running);
}