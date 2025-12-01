//
// Created by os on 12/1/25.
//

#include "../h/Kernel.hpp"
extern "C" void interrupt_trap(void);

void Kernel::initializeKernel()
{
    Kernel::setInterruptRoutine(&interrupt_trap);
}
void Kernel::interruptHandler(void)
{
    uint64 scause = Machine::readScause();
    if(scause == 0x0000000000000008UL || scause == 0x0000000000000009UL)
    {
        Machine::incrementSepc();
    }

}