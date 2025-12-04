//
// Created by os on 12/1/25.
//

#ifndef PROJECT_BASE_V1_1_KERNEL_H
#define PROJECT_BASE_V1_1_KERNEL_H
#include "Machine.hpp"
#include "MemoryAllocator.hpp"

#define NUM_OF_SYSTEM_CALLS 10


class Kernel {
public:
    Kernel() = delete;
    Kernel(const Kernel& kernel) = delete;
    Kernel& operator=(const Kernel& kernel) = delete;
    static void initializeKernel(void);
    enum NumberOfSystemCall {
        MEM_ALLOC = 0x1,
        MEM_FREE = 0x2,
        MEM_FREE_SPACE = 0x3,
        LARGEST_FREE_BLOCK = 0x4
    };

private:
    typedef struct ArgumentsOfSystemCall{
        uint64 a0, a1, a2, a3, a4, a5, a6;
    } ArgumentsOfSystemCall;
    static void setInterruptRoutine(void (*routine)(void));
    static void interruptHandler();
    static uint64 sys_malloc(ArgumentsOfSystemCall* arg);
    static uint64 sys_free(ArgumentsOfSystemCall* arg);
    static uint64 (*systemCallsTable[NUM_OF_SYSTEM_CALLS])(ArgumentsOfSystemCall* arg);
    static void initializeArguments(ArgumentsOfSystemCall* arg, uint64 basePointer);
};

inline void Kernel::setInterruptRoutine(void (*routine)(void)) {
    Machine::writeStvec((uint64) routine);
}


#endif //PROJECT_BASE_V1_1_KERNEL_H
