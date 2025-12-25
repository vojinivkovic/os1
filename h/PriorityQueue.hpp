//
// Created by os on 12/19/25.
//

#ifndef PROJECT_BASE_V1_1_PRIORITYQUEUE_H
#define PROJECT_BASE_V1_1_PRIORITYQUEUE_H
#include "../lib/hw.h"
#include "MemoryAllocator.hpp"

template <typename T, typename Compare>
class PriorityQueue
{
public:
    explicit PriorityQueue(Compare c) : cmp(c) {}

    void append(T* newElement);
    T* take();
    T* top();
    static void* operator new(size_t size);
    static void operator delete(void* obj);
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
    while(curr && cmp(curr, newElement))
    {
        newElement->setTimeToSleep(newElement->getTimeToSleep() - curr->getTimeToSleep());
        prev = curr;
        curr = curr->getNextElementdInQueue();
    }

    if(curr == head)
    {
        newElement->addElementToQueue(head);
        head->setTimeToSleep(head->getTimeToSleep() - newElement->getTimeToSleep());
        head = newElement;
    }
    else
    {
        newElement->addElementToQueue(curr);
        prev->addElementToQueue(newElement);
        curr->setTimeToSleep(curr->getTimeToSleep() - newElement->getTimeToSleep());
    }
}
template<typename T, typename Compare>
T* PriorityQueue<T, Compare>::take()
{
    T* oldElement = head;
    head = head->getNextElementInQueue();
    if(!head)
    {
        tail = nullptr;
    }
    return oldElement;
}
template<typename T, typename Compare>
void* PriorityQueue<T, Compare>::operator new(size_t size)
{
    size_t correctedSize = size + MemoryAllocator::getSizeOfMetaData();
    size_t numOfBlocks = correctedSize / MEM_BLOCK_SIZE;
    numOfBlocks += correctedSize % MEM_BLOCK_SIZE ? 1 : 0;
    return MemoryAllocator::allocateMemory(numOfBlocks);
}

template<typename T, typename Compare>
void PriorityQueue<T, Compare>::operator delete(void *obj)
{
    MemoryAllocator::freeMemory(obj);
}

template<typename T, typename Compare>
T* PriorityQueue<T, Compare>::top()
{
    return head;
}
#endif //PROJECT_BASE_V1_1_PRIORITYQUEUE_H