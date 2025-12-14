//
// Created by os on 12/13/25.
//

#ifndef PROJECT_BASE_V1_1_KSEMAPHORE_H
#define PROJECT_BASE_V1_1_KSEMAPHORE_H

class TCB;
class KSemaphore {
public:
    KSemaphore() = default;
    void initializeSemaphore(unsigned int value);
    void wait(uint64* returnValue);
    int signal();
	int close();
private:
    void blockThread(TCB* threadToBlock);
    int unblockThread();
    long semaphoreVal;
    TCB* headBlockedThread, *lastBlockedThread;
};


#endif //PROJECT_BASE_V1_1_KSEMAPHORE_H
