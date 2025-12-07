//
// Created by os on 12/5/25.
//

#ifndef PROJECT_BASE_V1_1_TCB_H
#define PROJECT_BASE_V1_1_TCB_H
#include "ObjectPool.hpp"
#include "MemoryAllocator.hpp"
#include "../lib/hw.h"
extern const size_t NUM_OF_THREADS_IN_POOL;
extern const size_t DEFAULT_SYSTEM_STACK_SIZE;


class TCB
{
public:
    using Body = void(*)(void*);
    TCB() = default;
    void initializeThread(Body body, void* stack, ObjectPool<TCB, NUM_OF_THREADS_IN_POOL>* pool);

private:

    typedef struct Context
    {
        uint64 ra;
        uint64 sp;
        uint64 ssp;
    } Context;

    Body body;
    Context context;
    ObjectPool<TCB, NUM_OF_THREADS_IN_POOL>* sourcePool;
    size_t timeSlice;
    uint64* stack;
    uint64* systemStack;
    TCB* state;
    bool isFinished;
};


#endif //PROJECT_BASE_V1_1_TCB_H
