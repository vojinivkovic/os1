//
// Created by os on 12/19/25.
//

#ifndef PROJECT_BASE_V1_1_PRIORITYQUEUE_H
#define PROJECT_BASE_V1_1_PRIORITYQUEUE_H
#include "../lib/hw.h"


template <typename T, typename Compare>
class PriorityQueue {
public:
    explicit PriorityQueue(Compare c) : cmp(c) {}

    void append(T* newElement);
    T* take();

    static void* operator new(size_t size);
private:
    T* head = nullptr, *tail = nullptr;
    Compare cmp;
};

template<typename T, typename Compare>
void PriorityQueue<T, Compare>::append(T *newElement)
{
    if(head == nullptr)
    {
        head = newElement;
    }

    T* curr = head, *prev = nullptr;
    while(curr && cmp(curr->getTimeToSleep(), newElement->getTimeToSleep()))
    {
        newElement->setTimeToSleep(newElement->getTimeToSleep() - curr->getTimeToSleep());
        prev = curr;
        curr = curr->getState();
    }

    if(curr == head)
    {
        newElement->addThreadToState(head);
        head->setTimeToSleep(head->getTimeToSleep() - newElement->getTimeToSlee());
        head = newElement;
    }
    else
    {
        newElement->addThreadToState(curr);
        prev->addThreadToState(newElement);
        curr->setTimeToSleep(curr->getTimeToSleep() - newElement->getTimeToSleep);
    }
}
template<typename T, typename Compare>
T* PriorityQueue<T, Compare>::take()
{
    T* oldElement = head;
    head = head->getState();
    if(!head)
    {
        tail = nullptr;
    }
    return oldElement;
}
template<typename T, typename Compare>
void* PriorityQueue<T, Compare>::operator new(size_t size)
{
    size_t numOfBlocks = size / MEM_BLOCK_SIZE;
    numOfBlocks += size % MEM_BLOCK_SIZE ? 1 : 0;
    return MemoryAllocator::allocateMemory(numOfBlocks);
}
#endif //PROJECT_BASE_V1_1_PRIORITYQUEUE_H