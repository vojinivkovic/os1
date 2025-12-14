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

class KSemaphore;
class TCB
{
public:
    using Body = void(*)(void*);
    TCB() = default;
    void initializeThread(Body body, void*arg, void* stack, void* systemStack, KernelConfig::Mode mode = KernelConfig::USER_MODE);

    size_t getTimeSlice() const { return timeSlice; }
    bool isFinished() const { return finished; }
    void setIsFinished() { finished = true; }

    void addThreadToState(TCB* newThread) { state = newThread; }
    TCB* getState() const { return state; }
    void resetState() {state = nullptr; }
    Context getContext() const { return context; }
    void* getUserStack() const { return userStack; }
    void* getSystemStack() const { return systemStack; }

    void setWakeUpReason(KernelConfig::WAKE_UP_REASON reason) { wakeUpReason = reason };
    KernelConfig::WAKE_UP_REASON getWakeUpReason() {return wakeUpReason; }
    void setSemaphoreOnWait (KSemaphore* semaphore) { waitOnSemaphore = semaphore; }
    KSemaphore* getSemaphoreOnWait() const { return waitOnSemaphore; }
    void resetSemaphoreOnWait() { waitOnSemaphore = nullptr; }
    static void dispatch();

    static TCB* getRunningThread() { return running; }
    static void setRunningThread(TCB* newRunningThread) { running = newRunningThread; }

    static size_t getNumOfTicks() { return numOfTicks; }
    static void resetNumOfTicks() { numOfTicks = DEFAULT_TIME_SLICE; }
    static void incrementNumOfTicks() { numOfTicks++; }

    typedef struct Context
    {
        uint64 ra;
        uint64 sp;
        KernelConfig::Mode mode;
    } Context;

private:



    Body body;
    Context context;
    void* userStack;
    void* systemStack;
    size_t timeSlice;
    void* arguments;
    KSemaphore* waitOnSemaphore;
    TCB* state;
    bool finished;
    KernelConfig::WAKE_UP_REASON wakeUpReason;

    static TCB* running;

    static size_t numOfTicks;
    static void threadWrapper();// ova f-ja ce sluziti kako bismo mogli da zavrsimo nit, a i da od nje pocne izvrsavanje svake niti

    static void yield(TCB* oldThread, TCB* newThread);




};


#endif //PROJECT_BASE_V1_1_TCB_H
