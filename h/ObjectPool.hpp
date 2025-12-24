//
// Created by os on 12/5/25.
//

#ifndef PROJECT_BASE_V1_1_OBJECTPOOL_H
#define PROJECT_BASE_V1_1_OBJECTPOOL_H
#include "../lib/hw.h"
#include "MemoryAllocator.hpp"


template <typename T, size_t numOfObjects>
class ObjectPool
{
public:
    ObjectPool(): headFreeObject(pool), nextObjectPool(nullptr), prevObjectPool(nullptr)
    {

        for(size_t i = 0; i < numOfObjects - 1; i++)
        {
            pool[i].nextFree = &(pool[i+1]);
        }
        pool[numOfObjects - 1].nextFree = nullptr;
    }

    static void* operator new(size_t size);
    static void operator delete(void* obj);
    T* mallocObject(ObjectPool<T, numOfObjects>** pool);
    int freeObject(T* obj);


private:

    typedef struct PoolObject
    {
        T object;
        PoolObject* nextFree;

    } PoolObject;

    PoolObject* getHeadFreeList(void) const
    {
        return headFreeObject;
    }
    ObjectPool<T, numOfObjects>* findFreePool(void);
    //static size_t countOfPools;
    PoolObject pool[numOfObjects];
    PoolObject* headFreeObject;
    ObjectPool<T, numOfObjects>* nextObjectPool;
    ObjectPool<T, numOfObjects>* prevObjectPool;
    //size_t id;

};


template<typename T, size_t numOfObjects>
void* ObjectPool<T, numOfObjects>::operator new(size_t size)
{
    size_t numOfBlocks = size / MEM_BLOCK_SIZE;
    numOfBlocks += size % MEM_BLOCK_SIZE ? 1 : 0;
    return MemoryAllocator::allocateMemory(numOfBlocks);
}
template<typename T, size_t numOfObjects>
void ObjectPool<T, numOfObjects>::operator delete(void *obj)
{
    MemoryAllocator::freeMemory(obj);
}

template<typename T, size_t numOfObjects>
ObjectPool<T, numOfObjects>* ObjectPool<T, numOfObjects>::findFreePool(void)
{
    ObjectPool<T, numOfObjects>* curr = this;
    for(; !curr->nextObjectPool && !curr->headFreeObject; curr = curr->nextObjectPool);
    return curr;
}

template<typename T, size_t numOfObjects>
T* ObjectPool<T, numOfObjects>::mallocObject(ObjectPool<T, numOfObjects>** addressOfPool)
{
    ObjectPool<T,numOfObjects>* currentPool = findFreePool();
    if (currentPool->headFreeObject)
    {
        PoolObject* temp = currentPool->headFreeObject;
        currentPool->headFreeObject = currentPool->headFreeObject->nextFree;
        *addressOfPool = currentPool;
        return &(temp->object);
    }
    else
    {
        ObjectPool<T, numOfObjects>* newPool = new ObjectPool();
        if(!newPool)
        {
            return nullptr;
        }
        newPool->prevObjectPool = currentPool;
        currentPool->nextObjectPool = newPool;

        PoolObject* temp = newPool->headFreeObject;
        newPool->headFreeObject = newPool->headFreeObject->nextFree;
        *addressOfPool = newPool;
        return &(temp->object);
    }
}

template<typename T, size_t numOfObjects>
int ObjectPool<T, numOfObjects>::freeObject(T *obj) {

    ObjectPool<T, numOfObjects>* curr = obj->getSourcePool();
    PoolObject* tempObj = (PoolObject*)obj;
    tempObj->nextFree = curr->headFreeObject;
    curr->headFreeObject = tempObj;

    return 0;
}
#endif //PROJECT_BASE_V1_1_OBJECTPOOL_H
