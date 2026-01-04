.extern _ZN6Kernel16interruptHandlerEv
.align 4
.global interrupt_trap
.global first_born
.type interrupt_trap, @function
interrupt_trap:
    addi sp, sp, -16
    sd t0, 8(sp)
    sd t1, 0(sp)

    addi t0, sp, 0
    csrr t1, sstatus
    andi t1, t1, 0x100
    bne t1, x0, system_mode

    csrr sp, sscratch

system_mode: ld t1, 0(t0)
    addi sp, sp, -256

    sd x0, 0 * 8(sp)
    sd x1, 1 * 8(sp)
    sd t0, 2 * 8(sp)
    .irp index,  3, 4, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
    sd x\index, \index * 8(sp)
    .endr
    ld t0, 8(t0)
    sd t0, 5 * 8(sp)

    addi s0, sp, 0

    call _ZN6Kernel16interruptHandlerEv

    ld x0, 0 * 8(sp)
    ld x1, 1 * 8(sp)
    .irp index,  3, 4, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
    ld x\index, \index * 8(sp)
    .endr

first_born: ld t0, 2 * 8(sp)
    addi sp, sp, 256

    csrw sscratch, sp

    addi sp, t0, 0
    ld t0, 8(sp)
    addi sp, sp, 16
    sret