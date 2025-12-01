.global system_call
.type system_call, @function
system_call:
    addi t0, a0, 0x0
    ld a0, 0x0(t0)
    ld a1, 0x8(t0)
    ld a2, 0x10(t0)
    ld a3, 0x18(t0)
    ld a4, 0x20(t0)
    ld a5, 0x28(t0)
    ld a6, 0x30(t0)
    ld a7, 0x38(t0)
    ecall
    sd a0, 0x0(t0)
    ret
