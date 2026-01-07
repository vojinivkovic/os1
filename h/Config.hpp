//
// Created by os on 12/8/25.
//

#ifndef PROJECT_BASE_V1_1_KERNELCONFIG_H
#define PROJECT_BASE_V1_1_KERNELCONFIG_H
#include "../lib/hw.h"

namespace KernelConfig
{
    constexpr size_t NUM_OF_THREADS_IN_POOL = 20;
    constexpr size_t NUM_OF_SEMAPHORES_IN_POOL = 10;
    constexpr size_t SIZE_INPUT_BUFFER = 100;
    constexpr size_t SIZE_OUTPUT_BUFFER = 100;
    constexpr size_t NUM_OF_SYSTEM_CALLS = 0x43;
    constexpr size_t DEFAULT_SYSTEM_STACK_SIZE = 1024;
    const int EOF = -1;

    enum StateOfThread
    {
        EXIT,
        READY,
        BLOCKED,
        FINISHED,
        RUNNING,
        ASLEEP
    };

    enum Mode
    {
        USER_MODE = 0x0 << 8,
        KERNEL_MODE = 0x1 << 8
    };
    enum WakeUpReason
    {
        WAKE_UP_SEMAPHORE_SIGNAL,
        WAKE_UP_SEMAPHORE_CLOSE,
        INPUT_BUFFER_FULL,
        OUTPUT_BUFFER_FULL
    };
    enum NumberOfSystemCall
    {
        MEM_ALLOC = 0x1,
        MEM_FREE = 0x2,
        MEM_FREE_SPACE = 0x3,
        LARGEST_FREE_BLOCK = 0x4,
        THREAD_CREATE = 0x11,
        THREAD_EXIT = 0x12,
        THREAD_DISPATCH = 0x13,
        THREAD_START = 0x14,
        THREAD_ID = 0x15,
        THREAD_FINISH = 0x16,
        THREAD_KILL = 0x17,
        THREAD_JOIN = 0x18,
        SEMAPHORE_OPEN = 0X21,
        SEMAPHORE_CLOSE = 0x22,
        SEMAPHORE_WAIT = 0x23,
        SEMAPHORE_SIGNAL = 0x24,
        TIME_SLEEP = 0x31,
        GETC = 0x41,
        PUTC = 0x42
    };
}


#endif //PROJECT_BASE_V1_1_KERNELCONFIG_H
