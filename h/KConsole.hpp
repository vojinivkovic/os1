//
// Created by os on 12/14/25.
//

#ifndef PROJECT_BASE_V1_1_KCONSOLE_H
#define PROJECT_BASE_V1_1_KCONSOLE_H
#include "Buffer.hpp"
#include "Config.hpp"

class TCB;
class KConsole {
public:
    KConsole() = delete;
    KConsole(const KConsole& console) = delete;
    KConsole& operator= (const KConsole& console) = delete;
    static void consume(void*);
    static TCB* getConsumerThread() { return consumerThread; }
    static void setConsumerThread(TCB* thread) { consumerThread = thread; }
    static bool isInputBufferEmpty() const { return inputBuffer->isBufferEmpty(); }
private:
    static TCB* consumerThread;
    static TCB* headThreadInputWait, *tailThreadInputWait;
    static Buffer<char, KernelConfig::SIZE_INPUT_BUFFER>* inputBuffer;
    static Buffer<char, KernelConfig::SIZE_OUTPUT_BUFFER>* outputBuffer;
};


#endif //PROJECT_BASE_V1_1_KCONSOLE_H
