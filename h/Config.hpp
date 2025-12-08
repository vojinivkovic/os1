//
// Created by os on 12/8/25.
//

#ifndef PROJECT_BASE_V1_1_KERNELCONFIG_H
#define PROJECT_BASE_V1_1_KERNELCONFIG_H
#include "../lib/hw.h"

namespace KernelConfig{
    constexpr size_t NUM_OF_THREADS_IN_POOL = 20;
    constexpr size_t NUM_OF_SYSTEM_CALLS = 0x42;
}


#endif //PROJECT_BASE_V1_1_KERNELCONFIG_H
