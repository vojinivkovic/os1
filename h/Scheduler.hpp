//
// Created by os on 12/8/25.
//

#ifndef PROJECT_BASE_V1_1_SCHEDULER_H
#define PROJECT_BASE_V1_1_SCHEDULER_H

#include "TCB.hpp"

class Scheduler {
public:
    Scheduler() = delete;
    Scheduler(const Scheduler& scheduler) = delete;
    Scheduler& operator=(const Scheduler& scheduler) = delete;
    static void put(TCB* readyThread);
    static TCB* get(void);
private:
    static TCB* firstReadyThread;
    static TCB* lastReadyThread;
};


#endif //PROJECT_BASE_V1_1_SCHEDULER_H
