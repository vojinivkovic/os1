//
// Created by os on 12/5/25.
//

#ifndef PROJECT_BASE_V1_1_OBJECTPOOL_H
#define PROJECT_BASE_V1_1_OBJECTPOOL_H
#include "../lib/hw.h"
#include "MemoryAllocator.hpp"


template <typename T, size_t numOfObjects>
class ObjectPool {
public:
    ObjectPool(): headFreeObject(pool), nextObjectPool(nullptr), prevObjectPool(nullptr), id(countOfPools++)
    {

        for(size_t i = 0; i < numOfObjects - 1; i++)
        {
            pool[i].nextFree = &(pool[i+1]);
        }
        pool[numOfObjects - 1] = nullptr;
    }

    static void* operator new(size_t size);
    T* mallocObject(void);
    int freeObject(T* obj);


private:

    typedef struct PoolObject
    {
        T object;
        PoolObject* nextFree;

    } PoolObject;

    PoolObject* getHeadFreeList(void)
    {
        return headFreeObject;
    }
    ObjectPool* findFreePool(void);
    static size_t countOfPools;
    PoolObject pool[numOfObjects];
    PoolObject* headFreeObject;
    ObjectPool* nextObjectPool;
    ObjectPool* prevObjectPool;
    size_t id;

};

template<typename T, size_t numOfObjects>
size_t ObjectPool<T, numOfObjects>::countOfPools = 0;


template<typename T, size_t numOfObjects>
void* ObjectPool<T, numOfObjects>::operator new(size_t size)
{
    size_t numOfBlocks = size / MEM_BLOCK_SIZE;
    numOfBlocks += size % MEM_BLOCK_SIZE ? 1 : 0;
    return MemoryAllocator::allocateMemory(numOfBlocks);
}

template<typename T, size_t numOfObjects>
ObjectPool<T, numOfObjects>* ObjectPool<T, numOfObjects>::findFreePool(void)
{
    ObjectPool* curr = this;
    for(; !curr->nextObjectPool && !curr->headFreeObject; curr = curr->nextObjectPool);
    return curr;
}

template<typename T, size_t numOfObjects>
T* ObjectPool<T, numOfObjects>::mallocObject(void)
{
    ObjectPool* currentPool = findFreePool();
    if (currentPool->headFreeObject)
    {
        PoolObject temp = *(currentPool->headFreeObject);
        currentPool->headFreeObject = currentPool->headFreeObject->nextFree;
        return &(temp.object);
    }
    else
    {
        ObjectPool* newPool = new ObjectPool();
        newPool->prevObjectPool = currentPool;
        currentPool->nextObjectPool = newPool;

        PoolObject temp = *(newPool->headFreeObject);
        newPool->headFreeObject = newPool->headFreeObject->nextFree;
        return &(temp.object);
    }
}

template<typename T, size_t numOfObjects>
int ObjectPool<T, numOfObjects>::freeObject(T *obj) {
    return 0;
}
#endif //PROJECT_BASE_V1_1_OBJECTPOOL_H
