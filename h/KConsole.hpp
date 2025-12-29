//
// Created by os on 12/14/25.
//

#ifndef PROJECT_BASE_V1_1_KCONSOLE_H
#define PROJECT_BASE_V1_1_KCONSOLE_H
#include "Buffer.hpp"
#include "Config.hpp"
#include "Queue.hpp"

class TCB;

class KConsole
{
public:
    KConsole() = delete;
    KConsole(const KConsole& console) = delete;
    KConsole& operator= (const KConsole& console) = delete;
    static void destroy();
    static void consumeOutputBuffer(void*);
    static void produceInputBuffer(void*);
    static void initialize();

    static TCB* getConsumerThread() { return consumerThread; }
    static void setConsumerThread(TCB* thread) { consumerThread = thread; }

    static TCB* getProducerThread() { return producerThread; }
    static void setProducerThread(TCB* thread) { producerThread = thread; }

    static bool isInputBufferEmpty() { return inputBuffer->isBufferEmpty(); }
    static bool isInputBufferFull() { return inputBuffer->isBufferFull(); }

    static bool isOutputBufferFull() { return outputBuffer->isBufferFull(); }
    static bool isOutputBufferEmpty() { return outputBuffer->isBufferEmpty(); }

    static void addThreadToInputWaitQueue(TCB* thread);
    static void removeThreadFromInputWaitQueue();

    static void addThreadToOutputWaitQueue(TCB* thread);
    static void removeThreadFromOutputWaitQueue();

    static void addCharToOutputBuffer(char c);
    static char getCharFromInputBuffer();
private:
    static TCB* consumerThread, *producerThread;
    static Queue<TCB>* inputWaitQueue, *outputWaitQueue;

    static Buffer<char, KernelConfig::SIZE_INPUT_BUFFER>* inputBuffer;
    static Buffer<char, KernelConfig::SIZE_OUTPUT_BUFFER>* outputBuffer;
};


#endif //PROJECT_BASE_V1_1_KCONSOLE_H
