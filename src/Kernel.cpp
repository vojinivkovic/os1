//
// Created by os on 12/1/25.
//

#include "../h/Kernel.hpp"
#include "../h/Scheduler.hpp"
#include "../h/TCB.hpp"
#include "../h/KSemaphore.hpp"
#include "../h/KConsole.hpp"

extern "C" void interrupt_trap(void);
extern "C" void context_switch(TCB::Context* oldContext, TCB::Context* newContext);

uint64 (*Kernel::systemCallsTable[KernelConfig::NUM_OF_SYSTEM_CALLS])(Kernel::ArgumentsOfSystemCall* arg) = {nullptr};
ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>* Kernel::poolOfThreads = new ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>();
ObjectPool<KSemaphore, KernelConfig::NUM_OF_SEMAPHORES_IN_POOL>* Kernel::poolOfSemaphores = new ObjectPool<KSemaphore, KernelConfig::NUM_OF_SEMAPHORES_IN_POOL>();
PriorityQueue<TCB, decltype(cmp)>* Kernel::queueOfAsleepThreads = new PriorityQueue<TCB, decltype(cmp)>(cmp);

void Kernel::makeConsumerThread()
{
    void* kernelSystemStack = Kernel::mallocSystemStack(KernelConfig::DEFAULT_SYSTEM_STACK_SIZE);
    ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>* sourcePool;
    TCB* consumerThread = poolOfThreads->mallocObject(&sourcePool);
    while(!consumerThread)
    {
        consumerThread = poolOfThreads->mallocObject(&sourcePool);
    }
    consumerThread->initializeThread(&KConsole::consumeOutputBuffer, nullptr, kernelSystemStack, kernelSystemStack, sourcePool, KernelConfig::BLOCKED, KernelConfig::KERNEL_MODE);
    KConsole::setConsumerThread(consumerThread);
}

void Kernel::makeProducerThread()
{
    void* kernelSystemStack = Kernel::mallocSystemStack(KernelConfig::DEFAULT_SYSTEM_STACK_SIZE);
    ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>* sourcePool;
    TCB* producerThread = poolOfThreads->mallocObject(&sourcePool);
    while(!producerThread)
    {
        producerThread = poolOfThreads->mallocObject(&sourcePool);
    }
    producerThread->initializeThread(&KConsole::produceInputBuffer, nullptr, kernelSystemStack, kernelSystemStack, sourcePool, KernelConfig::BLOCKED, KernelConfig::KERNEL_MODE);
    KConsole::setProducerThread(producerThread);
}
void Kernel::makeIdleThread()
{
    void* kernelSystemStack = Kernel::mallocSystemStack(KernelConfig::DEFAULT_SYSTEM_STACK_SIZE);
    ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>* sourcePool;
    TCB* idleThread = poolOfThreads->mallocObject(&sourcePool);
    while(!idleThread)
    {
        idleThread = poolOfThreads->mallocObject(&sourcePool);
    }
    idleThread->initializeThread(&kernelWorker, nullptr, kernelSystemStack, kernelSystemStack, sourcePool, KernelConfig::BLOCKED, KernelConfig::KERNEL_MODE);
    Scheduler::setIdleThread(idleThread);
}
void Kernel::initializeKernelThreads(void)
{
    makeConsumerThread();
    makeProducerThread();
    makeIdleThread();
}

void Kernel::initializeKernel()
{
    Kernel::setInterruptRoutine(&interrupt_trap);
    while(!poolOfThreads)
    {
     poolOfThreads = new ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>();
    }
    while(!poolOfSemaphores)
    {
        poolOfSemaphores = new ObjectPool<KSemaphore, KernelConfig::NUM_OF_SEMAPHORES_IN_POOL>();
    }

    initializeKernelThreads();
    initializeSystemCalls();

}
void Kernel::destroy()
{
    delete poolOfThreads;
    delete poolOfSemaphores;
    delete queueOfAsleepThreads;
}

void Kernel::initializeArguments(Kernel::ArgumentsOfSystemCall* arg, uint64 basePointer)
{
    __asm__ volatile("ld %[rd], 11*8(%[rs])":[rd]"=r"(arg->a0):[rs]"r"(basePointer));
    __asm__ volatile("ld %[rd], 12*8(%[rs])":[rd]"=r"(arg->a1):[rs]"r"(basePointer));
    __asm__ volatile("ld %[rd], 13*8(%[rs])":[rd]"=r"(arg->a2):[rs]"r"(basePointer));
    __asm__ volatile("ld %[rd], 14*8(%[rs])":[rd]"=r"(arg->a3):[rs]"r"(basePointer));
    __asm__ volatile("ld %[rd], 15*8(%[rs])":[rd]"=r"(arg->a4):[rs]"r"(basePointer));
    __asm__ volatile("ld %[rd], 16*8(%[rs])":[rd]"=r"(arg->a5):[rs]"r"(basePointer));
    __asm__ volatile("ld %[rd], 17*8(%[rs])":[rd]"=r"(arg->a6):[rs]"r"(basePointer));
}


void* Kernel::mallocSystemStack(size_t numOfBytes)
{
    size_t numOfBlocks = numOfBytes / MEM_BLOCK_SIZE;
    numOfBlocks += numOfBytes % MEM_BLOCK_SIZE ? 1 : 0;
    uint8* systemStack = (uint8*)MemoryAllocator::allocateMemory(numOfBlocks);
    return (void*)(&systemStack[KernelConfig::DEFAULT_SYSTEM_STACK_SIZE]);
}

void Kernel::wakeUpThreads()
{
    queueOfAsleepThreads->top()->decrementTimeToSleep();

    while(!queueOfAsleepThreads->top()->getTimeToSleep())
    {
        TCB* curr = queueOfAsleepThreads->take();
        curr->resetState();
        Scheduler::put(curr);
    }
}
void Kernel::interruptHandler()
{
    volatile uint64 basePointer;
    __asm__ volatile ("addi %[reg], s0, 0x0": [reg]"=r"(basePointer)); // Problem: da li mozemo biti 100% sigurni da ce s0 biti nepromenjen; resenje inline f-ja
    uint64 scause = Machine::readScause();
    switch (scause)
    {
        case 0x0000000000000008UL:
        case 0x0000000000000009UL:
        {

            // scause == 0x0000000000000008UL; software interrupt(ecall) from user mode
            // scause == 0x0000000000000009UL; software interrupt(ecall) from kernel(supervised) mode

            Machine::bc_sip(Machine::SSIP);

            uint64 sepc = Machine::readSepc() + 4;
            uint64 sstatus = Machine::readSstatus();

            uint64 numberOfEntry;
            __asm__ volatile ("ld %[rd], -176(%[rs])": [rd]"=r"(numberOfEntry):[rs]"r"(basePointer));

            ArgumentsOfSystemCall arg;
            initializeArguments(&arg, basePointer);
            systemCallsTable[numberOfEntry](&arg);

            __asm__ volatile("sd a0, -176(%[rs])"::[rs]"r"(basePointer));

            TCB::dispatch();

            Machine::writeSepc(sepc);
            Machine::writeSstatus(sstatus);
            break;
        }
        case 0x8000000000000001UL:
        {
            // interrupt from timer

            Machine::bc_sip(Machine::SSIP);
            TCB::incrementNumOfTicks();
            if (TCB::getNumOfTicks() >= TCB::getRunningThread()->getTimeSlice()) {
                TCB::resetNumOfTicks();
                uint64 sepc = Machine::readSepc() + 4;
                uint64 sstatus = Machine::readSstatus();

                TCB::dispatch();

                Machine::writeSepc(sepc);
                Machine::writeSstatus(sstatus);

            }
            wakeUpThreads();
            break;
        }
        case 0x8000000000000009UL:
        {
            // hardware interrupt from console
            Machine::bc_sip(Machine::SEIP);

            uint64 sepc = Machine::readSepc() + 4;
            uint64 sstatus = Machine::readSstatus();

            int numOfDevice = plic_claim();
            uint8 statusReg;
            __asm__ volatile("lb %[status], 0(%[address])": [status] "=r"(statusReg): [address] "r"(CONSOLE_STATUS));

            if (statusReg & CONSOLE_TX_STATUS_BIT) {
                if (KConsole::isOutputBufferEmpty()) {
                    plic_complete(numOfDevice);
                } else {
                    Scheduler::put(KConsole::getConsumerThread());
                }
            } else {
                if (KConsole::isInputBufferFull()) {
                    plic_complete(numOfDevice);
                } else {
                    Scheduler::put(KConsole::getProducerThread());
                }
            }

            TCB::dispatch();

            Machine::writeSepc(sepc);
            Machine::writeSstatus(sstatus);

            break;
        }
    }

}

void Kernel::kernelWorker(void*)
{
    while(1)
    {

    }
}

uint64 Kernel::sysMalloc(Kernel::ArgumentsOfSystemCall *arg)
{
//    uint64 returnValue;
//    returnValue = (uint64)MemoryAllocator::allocateMemory(arg->a0);
//    return returnValue;
    return (uint64)MemoryAllocator::allocateMemory(arg->a0);
}
uint64 Kernel::sysFree(Kernel::ArgumentsOfSystemCall *arg)
{
//    uint64 returnValue;
//    returnValue = (uint64)MemoryAllocator::freeMemory((void*)arg->a0);
//    return returnValue;
    return (uint64)MemoryAllocator::freeMemory((void*)arg->a0);
}
uint64 Kernel::sysGetFreeSpace(Kernel::ArgumentsOfSystemCall *arg)
{
//    uint64 returnValue;
//    returnValue = (uint64)MemoryAllocator::getFreeSpace();
//    return returnValue;
    return (uint64)MemoryAllocator::getFreeSpace();
}
uint64 Kernel::sysLargestFreeBlock(Kernel::ArgumentsOfSystemCall *arg)
{
//    uint64 returnValue;
//    returnValue = (uint64)MemoryAllocator::getLargestFreeBlock();
//    return (uint64)MemoryAllocator;
    return (uint64)MemoryAllocator::getLargestFreeBlock();
}
uint64 Kernel::sysThreadCreate(Kernel::ArgumentsOfSystemCall *arg)
{
    ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>* sourcePool;
    TCB* newThread = poolOfThreads->mallocObject(&sourcePool);
    if(!newThread)
    {
        return -1;
    }
    __asm__ volatile("sd %[ptrThread], 0(%[handle])"::[ptrThread]"r"(newThread), [handle]"r"(arg->a0));
    void* kernelSystemStack = Kernel::mallocSystemStack(KernelConfig::DEFAULT_SYSTEM_STACK_SIZE);
    newThread->initializeThread((TCB::Body) arg->a1, (void*)arg->a2, (void*)arg->a3, kernelSystemStack, sourcePool);
    return 0;
}
uint64 Kernel::sysThreadDispatch(Kernel::ArgumentsOfSystemCall *arg)
{
    TCB::dispatch();
    return 0;
}
uint64 Kernel::sysThreadExit(Kernel::ArgumentsOfSystemCall *arg)
{
//    if(MemoryAllocator::freeMemory(TCB::getRunningThread()->getSystemStack()) == -1)
//    {
//        return -1;
//    }

    TCB::getRunningThread()->setIsFinished();
//    if(MemoryAllocator::freeMemory(TCB::getRunningThread()->getUserStack()) == -1)
//    {
//        return -1;
//    }

    if(!TCB::getRunningThread()->getSemaphoreOnWait())
    {
        KSemaphore* tempSemaphore = TCB::getRunningThread()->getSemaphoreOnWait();
        tempSemaphore->removeThreadFromBlockedQueue(TCB::getRunningThread());
    }
    TCB* oldThread = TCB::getRunningThread();
    Kernel::poolOfThreads->freeObject(oldThread);
    delete oldThread;
    return 0;
}
uint64 Kernel::sysThreadStart(ArgumentsOfSystemCall *arg)
{
    Scheduler::put((TCB*)arg->a0);
    return 0;
}
uint64 Kernel::sysSemaphoreOpen(ArgumentsOfSystemCall *arg)
{
    ObjectPool<KSemaphore, KernelConfig::NUM_OF_SEMAPHORES_IN_POOL>* sourcePool;
    KSemaphore* newSemaphore = poolOfSemaphores->mallocObject(&sourcePool);
    if(!newSemaphore)
    {
        return -1;
    }
    __asm__ volatile("sd %[ptrSemaphore], 0(%[handle])"::[ptrSemaphore]"r"(newSemaphore), [handle]"r"(arg->a0));
    newSemaphore->initializeSemaphore((unsigned)arg->a1, sourcePool);
    return 0;
}

uint64 Kernel::sysSemaphoreClose(ArgumentsOfSystemCall *arg)
{
    uint64 returnValue;
    KSemaphore* tempSemaphore = (KSemaphore*)(arg->a0);
    returnValue = (uint64)tempSemaphore->close();
    Kernel::poolOfSemaphores->freeObject(tempSemaphore);
    delete tempSemaphore;
    return returnValue;
}

uint64 Kernel::sysSemaphoreWait(ArgumentsOfSystemCall *arg)
{
    KSemaphore* tempSemaphore = (KSemaphore*)(arg->a0);
    return (uint64)tempSemaphore->wait();
}

uint64 Kernel::sysSemaphoreSignal(ArgumentsOfSystemCall *arg)
{
    KSemaphore* tempSemaphore = (KSemaphore*)(arg->a0);
    return (uint64)tempSemaphore->signal();
}

uint64 Kernel::sysTimeSleep(ArgumentsOfSystemCall *arg)
{
    TCB* oldThread = TCB::getRunningThread();
    oldThread->resetState();
    oldThread->setTimeToSleep((size_t)arg->a0);
    queueOfAsleepThreads->append(oldThread);
    TCB::setRunningThread(Scheduler::get());
    context_switch(oldThread->getContext(), TCB::getRunningThread()->getContext());
    return 0;
}
uint64 Kernel::sysGetc(ArgumentsOfSystemCall *arg)
{
    if(KConsole::isInputBufferEmpty())
    {
        TCB* oldThread = TCB::getRunningThread();
        TCB::setRunningThread(Scheduler::get());
        oldThread->resetState();
        KConsole::addThreadToInputWaitQueue(oldThread);
        context_switch(oldThread->getContext(), TCB::getRunningThread()->getContext());
    }
    return (uint64)KConsole::getCharFromInputBuffer();
}
uint64 Kernel::sysPutc(ArgumentsOfSystemCall *arg)
{
    if(KConsole::isOutputBufferFull())
    {
        TCB* oldThread = TCB::getRunningThread();
        TCB::setRunningThread(Scheduler::get());
        oldThread->resetState();
        KConsole::addThreadToOutputWaitQueue(oldThread);
        context_switch(oldThread->getContext(), TCB::getRunningThread()->getContext());
    }
    KConsole::addCharToOutputBuffer(arg->a0);
    return 0;
}

void Kernel::initializeSystemCalls(void)
{
    systemCallsTable[KernelConfig::MEM_ALLOC] = &sysMalloc;
    systemCallsTable[KernelConfig::MEM_FREE] = &sysFree;
    systemCallsTable[KernelConfig::MEM_FREE_SPACE] = &sysGetFreeSpace;
    systemCallsTable[KernelConfig::LARGEST_FREE_BLOCK] = &sysLargestFreeBlock;
    systemCallsTable[KernelConfig::THREAD_CREATE] = &sysThreadCreate;
    systemCallsTable[KernelConfig::THREAD_DISPATCH] = &sysThreadDispatch;
    systemCallsTable[KernelConfig::THREAD_EXIT] = &sysThreadExit;
    systemCallsTable[KernelConfig::THREAD_START] = &sysThreadStart;
    systemCallsTable[KernelConfig::SEMAPHORE_OPEN] = &sysSemaphoreOpen;
    systemCallsTable[KernelConfig::SEMAPHORE_CLOSE] = &sysSemaphoreClose;
    systemCallsTable[KernelConfig::SEMAPHORE_SIGNAL] = &sysSemaphoreSignal;
    systemCallsTable[KernelConfig::SEMAPHORE_WAIT] = &sysSemaphoreWait;
    systemCallsTable[KernelConfig::TIME_SLEEP] = &sysTimeSleep;
    systemCallsTable[KernelConfig::GETC] = &sysGetc;
    systemCallsTable[KernelConfig::PUTC] = &sysPutc;
}