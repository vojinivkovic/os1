//
// Created by os on 12/14/25.
//

#include "../h/KConsole.hpp"
Buffer<char, KernelConfig::SIZE_INPUT_BUFFER>* KConsole::inputBuffer = new Buffer<char, KernelConfig::SIZE_INPUT_BUFFER>();
Buffer<char, KernelConfig::SIZE_OUTPUT_BUFFER>* KConsole::outputBuffer = new Buffer<char, KernelConfig::SIZE_OUTPUT_BUFFER>();
TCB* KConsole::consumerThread = nullptr;
TCB* KConsole::headThreadInputWait = nullptr;
TCB* KConsole::tailThreadInputWait = nullptr;
