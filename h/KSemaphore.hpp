//
// Created by os on 12/13/25.
//

#ifndef PROJECT_BASE_V1_1_KSEMAPHORE_H
#define PROJECT_BASE_V1_1_KSEMAPHORE_H
#include "Config.hpp"
#include "ObjectPool.hpp"

class TCB;
class KSemaphore {
public:
    KSemaphore() = default;
    void initializeSemaphore(unsigned int value, ObjectPool<KSemaphore, KernelConfig::NUM_OF_SEMAPHORES_IN_POOL>* pool);
    void removeThreadFromWaitQueue(TCB* thread);
    ObjectPool<KSemaphore, KernelConfig::NUM_OF_SEMAPHORES_IN_POOL>* getSourcePool() { return sourcePool; }
    void wait();
    int signal();
	int close();
private:
    void blockThread(TCB* threadToBlock);
    int unblockThread(KernelConfig::WAKE_UP_REASON reason);
    long semaphoreVal;
    TCB* headBlockedThread, *lastBlockedThread;
    ObjectPool<KSemaphore, KernelConfig::NUM_OF_SEMAPHORES_IN_POOL>* sourcePool;
};


#endif //PROJECT_BASE_V1_1_KSEMAPHORE_H
