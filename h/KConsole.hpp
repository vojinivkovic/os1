//
// Created by os on 12/14/25.
//

#ifndef PROJECT_BASE_V1_1_KCONSOLE_H
#define PROJECT_BASE_V1_1_KCONSOLE_H
#include "KBuffer.hpp"
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

    static bool isInputBufferEmpty();
    static bool isInputBufferFull();

    static bool isOutputBufferFull();
    static bool isOutputBufferEmpty();

    static void addThreadToInputWaitQueue(TCB* thread);
    static void removeThreadFromInputWaitQueue();
    //static TCB* getInputWaitQueue() { return }

    static void addThreadToOutputWaitQueue(TCB* thread);
    static void removeThreadFromOutputWaitQueue();

    static void addCharToOutputBuffer(char c);
    static char getCharFromInputBuffer();

    static void setOutputBufferReady() { outputBufferReady = true; }
    static void resetOutputBufferReady() { outputBufferReady = false; }
    static bool getOutputBufferReady() { return outputBufferReady; }

    static void setInputBufferReady() { inputBufferReady = true; }
    static void resetInputBufferReady() { outputBufferReady = false; }
    static bool getInputBufferReady() { return inputBufferReady; }
private:
    static TCB* consumerThread, *producerThread;
    static Queue<TCB>* inputWaitQueue, *outputWaitQueue;

    static KBuffer* inputBuffer;
    static KBuffer* outputBuffer;
    static bool outputBufferReady;
    static bool inputBufferReady;
};


#endif //PROJECT_BASE_V1_1_KCONSOLE_H
