//
// Created by os on 12/13/25.
//

#ifndef PROJECT_BASE_V1_1_KSEMAPHORE_H
#define PROJECT_BASE_V1_1_KSEMAPHORE_H
#include "Config.hpp"


class TCB;
class KSemaphore {
public:
    KSemaphore() = default;
    void initializeSemaphore(unsigned int value);
    void removeThreadFromWaitQueue(TCB* thread);
    void wait();
    int signal();
	int close();
private:
    void blockThread(TCB* threadToBlock);
    int unblockThread(KernelConfig::WAKE_UP_REASON reason);
    long semaphoreVal;
    TCB* headBlockedThread, *lastBlockedThread;
};


#endif //PROJECT_BASE_V1_1_KSEMAPHORE_H
