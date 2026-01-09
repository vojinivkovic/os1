//
// Created by os on 12/16/25.
//

#ifndef PROJECT_BASE_V1_1_QUEUE_H
#define PROJECT_BASE_V1_1_QUEUE_H
#include "../lib/hw.h"
#include "MemoryAllocator.hpp"
#include "MetaData.hpp"

template<typename T>
class Queue
{
public:
    Queue() = default;

    void append(T* newElement);
    T* take();
    void removeElement(T* element);
    bool isQueueEmpty() const { return !head; }
    T* findElement(uint64 id) const;
    T* top() const { return head; };

    static void* operator new(size_t size);
    static void operator delete(void* obj);
private:
    T* head = nullptr, *tail = nullptr;
};

template<typename T>
void Queue<T>::append(T *newElement)
{
    if(!head)
    {
        head = newElement;
    }
    else
    {
        tail->addElementToQueue(newElement);
    }
    tail = newElement;
}
template<typename T>
T* Queue<T>::take()
{
    if(!head)
    {
        return nullptr;
    }
    T* oldElement = head;
    head = head->getNextElementInQueue();
    if(!head)
    {
        tail = nullptr;
    }
    return oldElement;
}

template<typename T>
void Queue<T>::removeElement(T *element)
{
    T* prev = nullptr, * curr = head;
    while(element != curr && curr)
    {
        prev = curr;
        curr = curr->getNextElementInQueue();
    }
    if(!prev)
    {
        head = head->getNextElementInQueue();
        if(!head)
        {
            tail = nullptr;
        }
    }
    else
    {
        prev->addElementToQueue(element->getNextElementInQueue());
        if(element == tail)
        {
            tail = prev;
        }
    }
}
template<typename T>
T* Queue<T>::findElement(uint64 id) const
{
    for(T* curr = head; curr; curr = curr->getNextElementInQueue())
    {
        if(curr->getID() == id)
        {
            return curr;
        }
    }
    return nullptr;
}

template<typename T>
void* Queue<T>::operator new(size_t size)
{
    size_t correctedSize = size + getSizeOfMetaData();
    size_t numOfBlocks = correctedSize / MEM_BLOCK_SIZE;
    numOfBlocks += correctedSize % MEM_BLOCK_SIZE ? 1 : 0;
    return MemoryAllocator::allocateMemory(numOfBlocks);
}
template<typename T>
void Queue<T>::operator delete(void *obj)
{
    MemoryAllocator::freeMemory(obj);
}
#endif //PROJECT_BASE_V1_1_QUEUE_H
