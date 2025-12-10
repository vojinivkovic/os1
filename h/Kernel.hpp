//
// Created by os on 12/1/25.
//

#ifndef PROJECT_BASE_V1_1_KERNEL_H
#define PROJECT_BASE_V1_1_KERNEL_H
#include "Machine.hpp"
#include "MemoryAllocator.hpp"
#include "Config.hpp"
#include "ObjectPool.hpp"
#include "TCB.hpp"

class Kernel
{
public:
    Kernel() = delete;
    Kernel(const Kernel& kernel) = delete;
    Kernel& operator=(const Kernel& kernel) = delete;
    static void initializeKernel(void);


private:
    typedef struct ArgumentsOfSystemCall
    {
        uint64 a0, a1, a2, a3, a4, a5, a6;
    } ArgumentsOfSystemCall;

    static void setInterruptRoutine(void (*routine)(void));
    static void interruptHandler();

    static uint64 sysMalloc(ArgumentsOfSystemCall* arg);
    static uint64 sysFree(ArgumentsOfSystemCall* arg);
    static uint64 sysGetFreeSpace(ArgumentsOfSystemCall* arg);
    static uint64 sysLargestFreeBlock(ArgumentsOfSystemCall* arg);
    static uint64 sysThreadCreate(ArgumentsOfSystemCall* arg);
    static uint64 sysThreadDispatch(ArgumentsOfSystemCall* arg);
    static uint64 sysThreadExit(ArgumentsOfSystemCall* arg);

    static uint64 (*systemCallsTable[KernelConfig::NUM_OF_SYSTEM_CALLS])(ArgumentsOfSystemCall* arg);
    static void initializeArguments(ArgumentsOfSystemCall* arg, uint64 basePointer);

    static ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>* poolOfThreads;

    //static TCB* runningThread;

};

inline void Kernel::setInterruptRoutine(void (*routine)(void))
{
    Machine::writeStvec((uint64) routine);
}


#endif //PROJECT_BASE_V1_1_KERNEL_H
