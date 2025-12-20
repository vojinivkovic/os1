//
// Created by os on 12/16/25.
//

#ifndef PROJECT_BASE_V1_1_QUEUE_H
#define PROJECT_BASE_V1_1_QUEUE_H
#include "../lib/hw.h"

template<typename T>
class Queue {
public:
    Queue() = default;

    void append(T* newElement);
    T* take();
    void removeElement(T* element);
    bool isQueueEmpty() const { return !head; }

    static void* operator new(size_t size);
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
        tail->addThreadToState(newElement);
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
    head = head->getState();
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
        curr = curr->getState();
    }
    if(!prev)
    {
        head = head->getState();
        if(!head)
        {
            tail = nullptr;
        }
    }
    else
    {
        prev->addThreadToState(element->getState());
        if(element == tail)
        {
            tail = prev;
        }
    }
}
template<typename T>
void* Queue<T>::operator new(size_t size)
{
    size_t numOfBlocks = size / MEM_BLOCK_SIZE;
    numOfBlocks += size % MEM_BLOCK_SIZE ? 1 : 0;
    return MemoryAllocator::allocateMemory(numOfBlocks);
}

#endif //PROJECT_BASE_V1_1_QUEUE_H
