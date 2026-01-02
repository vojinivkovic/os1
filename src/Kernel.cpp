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
void userMain();

uint64 (*Kernel::systemCallsTable[KernelConfig::NUM_OF_SYSTEM_CALLS])(Kernel::ArgumentsOfSystemCall* arg) = {nullptr};
ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>* Kernel::poolOfThreads = nullptr;
ObjectPool<KSemaphore, KernelConfig::NUM_OF_SEMAPHORES_IN_POOL>* Kernel::poolOfSemaphores = nullptr;
PriorityQueue<TCB, decltype(cmp)>* Kernel::queueOfAsleepThreads = nullptr;
Queue<KSemaphore>* Kernel::queueOfOpenedSemaphores = nullptr;
TCB* Kernel::demonThread = nullptr;
KSemaphore* Kernel::semaphoreInputBuffer = nullptr;
KSemaphore* Kernel::semaphoreOutputBuffer = nullptr;
bool Kernel::outputBufferReady = false;
bool Kernel::inputBufferReady = false;

void Kernel::makeConsumerThread()
{
    void* kernelSystemStack = Kernel::mallocSystemStack(KernelConfig::DEFAULT_SYSTEM_STACK_SIZE);
    ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>* sourcePool;
    TCB* consumerThread = poolOfThreads->mallocObject(&sourcePool);
    while(!consumerThread)
    {
        consumerThread = poolOfThreads->mallocObject(&sourcePool);
    }
    consumerThread->initializeThread(&KConsole::consumeOutputBuffer, nullptr, kernelSystemStack, kernelSystemStack, sourcePool, KernelConfig::BLOCKED, KernelConfig::KERNEL_MODE,
                                     true);
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
    producerThread->initializeThread(&KConsole::produceInputBuffer, nullptr, kernelSystemStack, kernelSystemStack, sourcePool, KernelConfig::BLOCKED, KernelConfig::KERNEL_MODE,
                                     true);
    KConsole::setProducerThread(producerThread);
}
void Kernel::makeDemonThread()
{
    void* kernelSystemStack = Kernel::mallocSystemStack(KernelConfig::DEFAULT_SYSTEM_STACK_SIZE);
    ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>* sourcePool;
    demonThread = poolOfThreads->mallocObject(&sourcePool);
    while(!demonThread)
    {
        demonThread = poolOfThreads->mallocObject(&sourcePool);
    }
    demonThread->initializeThread(&kernelWorker, nullptr, kernelSystemStack, kernelSystemStack, sourcePool, KernelConfig::READY, KernelConfig::KERNEL_MODE,
                                  false);
    Scheduler::setIdleThread(demonThread);
}
void Kernel::initializeKernelThreads(void)
{
    makeConsumerThread();
    makeProducerThread();
    makeDemonThread();
}
void Kernel::initializeKernelSemaphores(void)
{
    ObjectPool<KSemaphore, KernelConfig::NUM_OF_SEMAPHORES_IN_POOL>* sourcePoolOutput, *sourcePoolInput;
    semaphoreOutputBuffer = poolOfSemaphores->mallocObject(&sourcePoolOutput);
    while(!semaphoreOutputBuffer)
    {
        semaphoreOutputBuffer = poolOfSemaphores->mallocObject(&sourcePoolOutput);
    }
    semaphoreOutputBuffer->initializeSemaphore(1, sourcePoolOutput);

    semaphoreInputBuffer = poolOfSemaphores->mallocObject(&sourcePoolInput);
    while(!semaphoreInputBuffer)
    {
        semaphoreInputBuffer =  poolOfSemaphores->mallocObject(&sourcePoolInput);
    }
    semaphoreInputBuffer->initializeSemaphore(1, sourcePoolInput);

}
void Kernel::initializeKernel()
{
    MemoryAllocator::initialize();

    Kernel::setInterruptRoutine(&interrupt_trap);
    poolOfThreads = new ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>();
    poolOfSemaphores = new ObjectPool<KSemaphore, KernelConfig::NUM_OF_SEMAPHORES_IN_POOL>();
    queueOfAsleepThreads = new PriorityQueue<TCB, decltype(cmp)>(cmp);
    queueOfOpenedSemaphores = new Queue<KSemaphore>();

    KConsole::initialize();
    Scheduler::initialize();

    while(!poolOfThreads)
    {
     poolOfThreads = new ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>();
    }
    while(!poolOfSemaphores)
    {
        poolOfSemaphores = new ObjectPool<KSemaphore, KernelConfig::NUM_OF_SEMAPHORES_IN_POOL>();
    }

    initializeKernelSemaphores();
    initializeKernelThreads();
    initializeSystemCalls();
    outputBufferReady = false;
    inputBufferReady = false;

}
void Kernel::destroy()
{
    delete poolOfThreads;
    delete poolOfSemaphores;
    delete queueOfAsleepThreads;
    delete queueOfOpenedSemaphores;
    delete KConsole::getProducerThread();
    delete KConsole::getConsumerThread();
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
    size_t correctedSize = numOfBytes + getSizeOfMetaData();
    size_t numOfBlocks = correctedSize / MEM_BLOCK_SIZE;
    numOfBlocks += correctedSize % MEM_BLOCK_SIZE ? 1 : 0;
    uint8* systemStack = (uint8*)MemoryAllocator::allocateMemory(numOfBlocks);
    return (void*)(&systemStack[KernelConfig::DEFAULT_SYSTEM_STACK_SIZE]);
}

void Kernel::wakeUpThreads()
{
    if(!queueOfAsleepThreads->top())
    {
        return;
    }
    queueOfAsleepThreads->top()->decrementTimeToSleep();

    while(!queueOfAsleepThreads->top()->getTimeToSleep())
    {
        TCB* curr = queueOfAsleepThreads->take();
        curr->resetNextThreadInQueue();
        curr->setStateOfThread(KernelConfig::READY);
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

                uint64 sepc = Machine::readSepc();
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

            uint64 sepc = Machine::readSepc();
            uint64 sstatus = Machine::readSstatus();

//int numOfDevice = plic_claim();
            uint8 statusReg;
            __asm__ volatile("lb %[status], 0(%[address])": [status] "=r"(statusReg): [address] "r"(CONSOLE_STATUS));

            if (statusReg & CONSOLE_TX_STATUS_BIT) {
                outputBufferReady = true;
                if (!KConsole::isOutputBufferEmpty())
                {
                    KConsole::getConsumerThread()->setStateOfThread(KernelConfig::READY);
                    Scheduler::put(KConsole::getConsumerThread());
                }
            } else {
                inputBufferReady = true;
                if (!KConsole::isInputBufferFull())
                {
                    KConsole::getProducerThread()->setStateOfThread(KernelConfig::READY);
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
void Kernel::userWorker(void *)
{
    userMain();
}
void Kernel::kernelWorker(void*)
{
    void* systemStack = Kernel::mallocSystemStack(KernelConfig::DEFAULT_SYSTEM_STACK_SIZE);

    size_t correctedSize = DEFAULT_STACK_SIZE + getSizeOfMetaData();
    size_t numOfBlocks = correctedSize / MEM_BLOCK_SIZE;
    numOfBlocks += correctedSize % MEM_BLOCK_SIZE ? 1 : 0;
    uint8* userStack = (uint8*)MemoryAllocator::allocateMemory(numOfBlocks);

    //return (void*)(&systemStack[KernelConfig::DEFAULT_SYSTEM_STACK_SIZE]);
    ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>* sourcePool;
    TCB* userThread = poolOfThreads->mallocObject(&sourcePool);

    while(!userThread)
    {
        userThread = poolOfThreads->mallocObject(&sourcePool);
    }
    userThread->initializeThread(&userWorker, nullptr, &(userStack[DEFAULT_STACK_SIZE]), systemStack, sourcePool, KernelConfig::BLOCKED, KernelConfig::USER_MODE);
    //Scheduler::setIdleThread(demonThread);
    //postaviti odgovarajucu vrednost za prekide, odnosno dozvoliti prekide
    TCB::start(userThread);
    TCB::dispatch();
    Machine::bs_sstatus(Machine::SPIE);
    Machine::bs_sstatus(Machine::SIE);
    while(1)
    {

    }
}
void Kernel::startExecution()
{
    TCB::setRunningThread(demonThread);
    //TCB::dispatch();
    Machine::writeRa(demonThread->getContext()->ra);
    Machine::writeSp(demonThread->getContext()->sp);
    Machine::writeSepc(demonThread->getContext()->sepc);
    Machine::writeSstatus(demonThread->getContext()->sstatus);
    __asm__ volatile ("ret");

}
uint64 Kernel::sysMalloc(Kernel::ArgumentsOfSystemCall *arg)
{
    return (uint64)MemoryAllocator::allocateMemory(arg->a0);
}
uint64 Kernel::sysFree(Kernel::ArgumentsOfSystemCall *arg)
{
    return (uint64)MemoryAllocator::freeMemory((void*)arg->a0);
}
uint64 Kernel::sysGetFreeSpace(Kernel::ArgumentsOfSystemCall *arg)
{
    return (uint64)MemoryAllocator::getFreeSpace();
}
uint64 Kernel::sysLargestFreeBlock(Kernel::ArgumentsOfSystemCall *arg)
{
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
    void* kernelSystemStack = Kernel::mallocSystemStack(KernelConfig::DEFAULT_SYSTEM_STACK_SIZE);
    if(!kernelSystemStack)
    {
        return -1;
    }
    __asm__ volatile("sd %[ptrThread], 0(%[handle])"::[ptrThread]"r"(newThread), [handle]"r"(arg->a0));

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
    TCB* oldThread = TCB::getRunningThread();
    oldThread->setIsFinished();
    oldThread->setStateOfThread(KernelConfig::FINISHED);

    // da li ce ovaj uslov biti ikada ispunjen??
//    if(!TCB::getRunningThread()->getSemaphoreOnWait())
//    {
//        KSemaphore* tempSemaphore = TCB::getRunningThread()->getSemaphoreOnWait();
//        tempSemaphore->removeThreadFromBlockedQueue(TCB::getRunningThread());
//    }

    oldThread->freeWaitThreads();
//    oldThread->resetQueueOfWhichIsPart();
//    oldThread->resetNextThreadInQueue();
    return 0;
}
uint64 Kernel::sysThreadStart(ArgumentsOfSystemCall *arg)
{
    TCB* tempThread = (TCB*)(arg->a0);
    if(!tempThread)
    {
        return -1;
    }

    if(tempThread->getStateOfThread() == KernelConfig::TERMINATED)
    {
        return -1;
    }
    tempThread->setStateOfThread(KernelConfig::READY);
    Scheduler::put(tempThread);
    return 0;
}
uint64 Kernel::sysThreadJoin(ArgumentsOfSystemCall *arg)
{
    TCB* tempThread = (TCB*)(arg->a0);
    if(!tempThread->isFinished())
    {
        TCB* oldThread = TCB::getRunningThread();
        oldThread->resetNextThreadInQueue();
        oldThread->setStateOfThread(KernelConfig::BLOCKED);
        oldThread->setQueueOfWhichIsPart(tempThread->getWaitQueue());
        tempThread->addThreadToWaitQueue(oldThread);
        TCB::setRunningThread(Scheduler::get());
        context_switch(oldThread->getContext(), TCB::getRunningThread()->getContext());

    }

    if(tempThread->getStateOfThread() == KernelConfig::TERMINATED)
    {
        return 0;
    }
    delete tempThread;
    poolOfThreads->freeObject(tempThread);
    return 0;
}
uint64 Kernel::sysThreadTerminate(ArgumentsOfSystemCall *arg)
{
    TCB* tempThread = (TCB*)(arg->a0);
    tempThread->setIsFinished();
    tempThread->setStateOfThread(KernelConfig::FINISHED);
    tempThread->freeWaitThreads();
    if(tempThread->getStateOfThread() == KernelConfig::BLOCKED)
    {
        tempThread->getQueueOfWhichIsPart()->removeElement(tempThread);
    }
    else if (tempThread->getStateOfThread() == KernelConfig::ASLEEP)
    {
        queueOfAsleepThreads->removeElement(tempThread);
    }

    tempThread->resetQueueOfWhichIsPart();
    tempThread->resetNextThreadInQueue();
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
    newSemaphore->initializeSemaphore((unsigned)arg->a1, sourcePool);
    queueOfOpenedSemaphores->append(newSemaphore);
    __asm__ volatile("sd %[semaphoreHandle], 0(%[handle])"::[semaphoreHandle]"r"(newSemaphore->getID()), [handle]"r"(arg->a0));
    return 0;
}

uint64 Kernel::sysSemaphoreClose(ArgumentsOfSystemCall *arg)
{
    uint64 returnValue;
    KSemaphore* tempSemaphore = queueOfOpenedSemaphores->findElement((uint64)arg->a0);
    if(!tempSemaphore)
    {
        return -1;
    }
    returnValue = (uint64)tempSemaphore->close();
    queueOfOpenedSemaphores->removeElement(tempSemaphore);
    tempSemaphore->resetNextSemaphoreInQueue();
    delete tempSemaphore;
    Kernel::poolOfSemaphores->freeObject(tempSemaphore);

    return returnValue;
}

uint64 Kernel::sysSemaphoreWait(ArgumentsOfSystemCall *arg)
{
    KSemaphore* tempSemaphore = queueOfOpenedSemaphores->findElement((uint64)arg->a0);
    if(!tempSemaphore)
    {
        return -1;
    }
    return (uint64)tempSemaphore->wait();
}

uint64 Kernel::sysSemaphoreSignal(ArgumentsOfSystemCall *arg)
{
    KSemaphore* tempSemaphore = queueOfOpenedSemaphores->findElement(arg->a0);
    if(!tempSemaphore)
    {
        return -1;
    }
    return (uint64)tempSemaphore->signal();
}

uint64 Kernel::sysTimeSleep(ArgumentsOfSystemCall *arg)
{
    TCB* oldThread = TCB::getRunningThread();
    oldThread->resetNextThreadInQueue();
    oldThread->setTimeToSleep((size_t)arg->a0);
    oldThread->setStateOfThread(KernelConfig::ASLEEP);
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
        oldThread->resetNextThreadInQueue();
        KConsole::addThreadToInputWaitQueue(oldThread);
        context_switch(oldThread->getContext(), TCB::getRunningThread()->getContext());
    }
    semaphoreInputBuffer->wait();
    semaphoreInputBuffer->signal();
    return (uint64)KConsole::getCharFromInputBuffer();
}
uint64 Kernel::sysPutc(ArgumentsOfSystemCall *arg)
{

    if(KConsole::isOutputBufferFull())
    {
        TCB* oldThread = TCB::getRunningThread();
        TCB::setRunningThread(Scheduler::get());
        oldThread->resetNextThreadInQueue();
        KConsole::addThreadToOutputWaitQueue(oldThread);
        context_switch(oldThread->getContext(), TCB::getRunningThread()->getContext());
    }
    semaphoreOutputBuffer->wait();
    KConsole::addCharToOutputBuffer(arg->a0);
    semaphoreOutputBuffer->signal();
    if(outputBufferReady && KConsole::getConsumerThread()->getStateOfThread() == KernelConfig::BLOCKED)
    {
        KConsole::getConsumerThread()->setStateOfThread(KernelConfig::READY);
        Scheduler::put(KConsole::getConsumerThread());
    }

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
    systemCallsTable[KernelConfig::THREAD_JOIN] = &sysThreadJoin;
    systemCallsTable[KernelConfig::THREAD_TERMINATE] = &sysThreadTerminate;
    systemCallsTable[KernelConfig::SEMAPHORE_OPEN] = &sysSemaphoreOpen;
    systemCallsTable[KernelConfig::SEMAPHORE_CLOSE] = &sysSemaphoreClose;
    systemCallsTable[KernelConfig::SEMAPHORE_SIGNAL] = &sysSemaphoreSignal;
    systemCallsTable[KernelConfig::SEMAPHORE_WAIT] = &sysSemaphoreWait;
    systemCallsTable[KernelConfig::TIME_SLEEP] = &sysTimeSleep;
    systemCallsTable[KernelConfig::GETC] = &sysGetc;
    systemCallsTable[KernelConfig::PUTC] = &sysPutc;
}