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
#include "Queue.hpp"

class KSemaphore;
class TCB
{
public:
    typedef struct Context
    {
        uint64 ra;
        uint64 sp;
        KernelConfig::Mode mode;
    } Context;
    using Body = void(*)(void*);
    TCB() = default;
    ~TCB();
    void initializeThread(Body body, void*arg, void* stack, void* systemStack, ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>* pool,
                          KernelConfig::StateOfThread state = KernelConfig::BLOCKED, KernelConfig::Mode mode = KernelConfig::USER_MODE);

    size_t getTimeSlice() const { return timeSlice; }
    bool isFinished() const { return finished; }
    void setIsFinished() { finished = true; }
    void setStateOfThread(KernelConfig::StateOfThread state) { stateOfThread = state; }
    KernelConfig::StateOfThread getStateOfThread() const { return stateOfThread; }
    size_t getTimeToSleep() const { return timeToSleep; }

    void setTimeToSleep(size_t time) { timeToSleep = time; }

    void decrementTimeToSleep() { timeToSleep--; };
    void addElementToQueue(TCB* newThread) { nextThreadInQueue = newThread; }
    TCB* getNextElementInQueue() const { return nextThreadInQueue; }
    void resetNextThreadInQueue() { nextThreadInQueue = nullptr; }
    Context* getContext() { return &context; }
    void* getUserStack() const { return userStack; }
    void* getSystemStack() const { return systemStack; }
    ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>* getSourcePool() { return sourcePool; }

    Queue<TCB*> getWaitQueue() const { return queueOfWaitThreads; }
    Queue<TCB>* getQueueOfWhichIsPart() const { return queueOfWhichIsPart; }
    void setQueueOfWhichIsPart(Queue<TCB>* queue) { queueOfWhichIsPart = queue; }
    void resetQueueOfWhichIsPart() { queueOfWhichIsPart = nullptr; }
    void setWakeUpReason(KernelConfig::WakeUpReason reason) { wakeUpReason = reason; }
    KernelConfig::WakeUpReason getWakeUpReason() { return wakeUpReason; }
    void setSemaphoreOnWait (KSemaphore* semaphore) { waitOnSemaphore = semaphore; }
    KSemaphore* getSemaphoreOnWait() const { return waitOnSemaphore; }
    void resetSemaphoreOnWait() { waitOnSemaphore = nullptr; }
    void addThreadToWaitQueue(TCB* newThread);
    void freeWaitThreads();

    static void dispatch();
    static void start(TCB* readyElement);

    static TCB* getRunningThread() { return running; }
    static void setRunningThread(TCB* newRunningThread) { running = newRunningThread; }

    static size_t getNumOfTicks() { return numOfTicks; }
    static void resetNumOfTicks() { numOfTicks = DEFAULT_TIME_SLICE; }
    static void incrementNumOfTicks() { numOfTicks++; }



private:



    Body body;
    Context context;
    void* userStack;
    void* systemStack;
    size_t timeSlice;
    void* arguments;
    KSemaphore* waitOnSemaphore;
    TCB* nextThreadInQueue;
    KernelConfig::StateOfThread stateOfThread;
    bool finished;
    KernelConfig::WakeUpReason wakeUpReason;
    size_t timeToSleep;
    Queue<TCB>* queueOfWaitThreads;
    Queue<TCB>* queueOfWhichIsPart;
    ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>* sourcePool;


    static TCB* running;

    static size_t numOfTicks;
    static void threadWrapper();// ova f-ja ce sluziti kako bismo mogli da zavrsimo nit, a i da od nje pocne izvrsavanje svake niti

    static void yield(TCB* oldThread, TCB* newThread);




};


#endif //PROJECT_BASE_V1_1_TCB_H
