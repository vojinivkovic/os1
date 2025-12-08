//
// Created by os on 12/5/25.
//

#ifndef PROJECT_BASE_V1_1_TCB_H
#define PROJECT_BASE_V1_1_TCB_H
#include "ObjectPool.hpp"
#include "MemoryAllocator.hpp"
#include "../lib/hw.h"
#include "Config.hpp"
#include "Machine.hpp"

class Scheduler;
class TCB
{
public:
    using Body = void(*)(void*);
    TCB() = default;
    void initializeThread(Body body, void*arg, void* stack);


private:

    typedef struct Context
    {
        uint64 ra;
        uint64 sp;
    } Context;

    Body body;
    Context context;
    //ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>* sourcePool;
    size_t timeSlice;
    uint64* stack;
    uint64* systemStack;
    void* arguments;
    TCB* state;
    bool isFinished;
    static const size_t DEFAULT_SYSTEM_STACK_SIZE;
    static size_t numOfTicks;
    static void threadWrapper();
    friend class Scheduler;
};


#endif //PROJECT_BASE_V1_1_TCB_H
