.global context_switch
.type context_switch, @function
context_switch:
    sd ra, 0 * 8(a0)
    sd sp, 1 * 8(a0)


    ld ra, 0 * 8(a1)
    ld sp, 1 * 8(a1)
    ld t0, 2 * 8(a1)

    beq t0, x0, continue
    slli t0, t0, 8
    csrs sstatus, t0

continue: ret