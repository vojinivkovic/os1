//
// Created by os on 12/8/25.
//

#ifndef PROJECT_BASE_V1_1_KERNELCONFIG_H
#define PROJECT_BASE_V1_1_KERNELCONFIG_H
#include "../lib/hw.h"

namespace KernelConfig{
    constexpr size_t NUM_OF_THREADS_IN_POOL = 20;
    constexpr size_t NUM_OF_SYSTEM_CALLS = 0x42;
    enum NumberOfSystemCall
    {
        MEM_ALLOC = 0x1,
        MEM_FREE = 0x2,
        MEM_FREE_SPACE = 0x3,
        LARGEST_FREE_BLOCK = 0x4,
        THREAD_CREATE = 0x11,
        THREAD_EXIT = 0x12,
        THREAD_DISPATCH = 0x13
    };
}


#endif //PROJECT_BASE_V1_1_KERNELCONFIG_H
