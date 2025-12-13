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
    int wait();
    int signal();
private:
    long semaphoreVal;
    TCB* headBlockedThreads;
};


#endif //PROJECT_BASE_V1_1_KSEMAPHORE_H
