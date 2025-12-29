//
// Created by os on 12/8/25.
//

#ifndef PROJECT_BASE_V1_1_SCHEDULER_H
#define PROJECT_BASE_V1_1_SCHEDULER_H
#include "Queue.hpp"

class TCB;

class Scheduler
{
public:
    Scheduler() = delete;
    Scheduler(const Scheduler& scheduler) = delete;
    Scheduler& operator=(const Scheduler& scheduler) = delete;
    static void put(TCB* readyThread);
    static TCB* get(void);
    static void setIdleThread(TCB* thread) { idleThread = thread; }
    static void destroy();
    static void initialize();
private:
    static Queue<TCB>* queueReadyThreads;
    static TCB* idleThread;
};


#endif //PROJECT_BASE_V1_1_SCHEDULER_H
