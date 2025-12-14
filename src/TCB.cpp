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
    userStack = (void*)((uint8*)allocatedStack - DEFAULT_STACK_SIZE);
    systemStack = (void*)((uint8*)allocatedSystemStack - KernelConfig::DEFAULT_SYSTEM_STACK_SIZE);

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
    context_switch(&(oldThread->getContext()), &(newThread->getContext()));
}

void TCB::dispatch()
{
    TCB* oldThread = running;
    if(!oldThread->isFinished())
    {
        Scheduler::put(oldThread);
    }
    running = Scheduler::get();
    yield(oldThread, running);
}