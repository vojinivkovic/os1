//
// Created by os on 12/13/25.
//

#ifndef PROJECT_BASE_V1_1_KSEMAPHORE_H
#define PROJECT_BASE_V1_1_KSEMAPHORE_H
#include "Config.hpp"
#include "ObjectPool.hpp"
#include "Queue.hpp"

class TCB;
class KSemaphore
{
public:
    KSemaphore() = default;
    ~KSemaphore();
    void initializeSemaphore(unsigned value, ObjectPool<KSemaphore, KernelConfig::NUM_OF_SEMAPHORES_IN_POOL>* pool);
    void removeThreadFromBlockedQueue(TCB* thread);
    ObjectPool<KSemaphore, KernelConfig::NUM_OF_SEMAPHORES_IN_POOL>* getSourcePool() { return sourcePool; }
    int wait();
    int signal();
	int close();
	void addElementToQueue(KSemaphore* newSemaphore) { nextSemaphoreInQueue = newSemaphore; }
	KSemaphore* getNextElementInQueue() const { return nextSemaphoreInQueue; }
	void resetNextSemaphoreInQueue() { nextSemaphoreInQueue = nullptr; }
	uint64 getID() const { return semId; }
private:
    void blockThread(TCB* threadToBlock);
    int unblockThread(KernelConfig::WakeUpReason reason);
	static uint64 countOfSemaphores;
    long semaphoreVal;
	KSemaphore* nextSemaphoreInQueue;
	Queue<TCB>* queueBlockedThreads;
    ObjectPool<KSemaphore, KernelConfig::NUM_OF_SEMAPHORES_IN_POOL>* sourcePool;
    uint64 semId;
    long cap;
};


#endif //PROJECT_BASE_V1_1_KSEMAPHORE_H
