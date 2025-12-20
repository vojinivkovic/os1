
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00007117          	auipc	sp,0x7
    80000004:	2c013103          	ld	sp,704(sp) # 800072c0 <_GLOBAL_OFFSET_TABLE_+0x30>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	065030ef          	jal	ra,80003880 <start>

0000000080000020 <spin>:
    80000020:	0000006f          	j	80000020 <spin>
	...

0000000080001000 <copy_and_swap>:
# a1 holds expected value
# a2 holds desired value
# a0 holds return value, 0 if successful, !0 otherwise
.global copy_and_swap
copy_and_swap:
    lr.w t0, (a0)          # Load original value.
    80001000:	100522af          	lr.w	t0,(a0)
    bne t0, a1, fail       # Doesn’t match, so fail.
    80001004:	00b29a63          	bne	t0,a1,80001018 <fail>
    sc.w t0, a2, (a0)      # Try to update.
    80001008:	18c522af          	sc.w	t0,a2,(a0)
    bnez t0, copy_and_swap # Retry if store-conditional failed.
    8000100c:	fe029ae3          	bnez	t0,80001000 <copy_and_swap>
    li a0, 0               # Set return to success.
    80001010:	00000513          	li	a0,0
    jr ra                  # Return.
    80001014:	00008067          	ret

0000000080001018 <fail>:
    fail:
    li a0, 1               # Set return to failure.
    80001018:	00100513          	li	a0,1
    8000101c:	00008067          	ret

0000000080001020 <system_call>:
.global system_call
.type system_call, @function
system_call:
    addi t0, a0, 0x0
    80001020:	00050293          	mv	t0,a0
    ld a0, 0x0(t0)
    80001024:	0002b503          	ld	a0,0(t0)
    ld a1, 0x8(t0)
    80001028:	0082b583          	ld	a1,8(t0)
    ld a2, 0x10(t0)
    8000102c:	0102b603          	ld	a2,16(t0)
    ld a3, 0x18(t0)
    80001030:	0182b683          	ld	a3,24(t0)
    ld a4, 0x20(t0)
    80001034:	0202b703          	ld	a4,32(t0)
    ld a5, 0x28(t0)
    80001038:	0282b783          	ld	a5,40(t0)
    ld a6, 0x30(t0)
    8000103c:	0302b803          	ld	a6,48(t0)
    ld a7, 0x38(t0)
    80001040:	0382b883          	ld	a7,56(t0)
    ecall
    80001044:	00000073          	ecall
    ret
    80001048:	00008067          	ret
    8000104c:	0000                	unimp
	...

0000000080001050 <interrupt_trap>:
.extern _ZN6Kernel16interruptHandlerEv
.align 4
.global interrupt_trap
.type interrupt_trap, @function
interrupt_trap:
    addi sp, sp, -16
    80001050:	ff010113          	addi	sp,sp,-16
    sd t0, 8(sp)
    80001054:	00513423          	sd	t0,8(sp)

    csrr t0, sstatus
    80001058:	100022f3          	csrr	t0,sstatus
    andi t0, t0, 0x10
    8000105c:	0102f293          	andi	t0,t0,16
    bne t0, x0, system_stack
    80001060:	00029663          	bnez	t0,8000106c <system_stack>

    addi t0, sp, 0
    80001064:	00010293          	mv	t0,sp
    csrr sp, sscratch
    80001068:	14002173          	csrr	sp,sscratch

000000008000106c <system_stack>:

system_stack:    addi sp, sp, -256
    8000106c:	f0010113          	addi	sp,sp,-256

    sd x0, 0 * 8(sp)
    80001070:	00013023          	sd	zero,0(sp)
    sd x1, 1 * 8(sp)
    80001074:	00113423          	sd	ra,8(sp)
    sd t0, 2 * 8(sp)
    80001078:	00513823          	sd	t0,16(sp)
    .irp index,  3, 4, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
    sd x\index, \index * 8(sp)
    .endr
    8000107c:	00313c23          	sd	gp,24(sp)
    80001080:	02413023          	sd	tp,32(sp)
    80001084:	02613823          	sd	t1,48(sp)
    80001088:	02713c23          	sd	t2,56(sp)
    8000108c:	04813023          	sd	s0,64(sp)
    80001090:	04913423          	sd	s1,72(sp)
    80001094:	04a13823          	sd	a0,80(sp)
    80001098:	04b13c23          	sd	a1,88(sp)
    8000109c:	06c13023          	sd	a2,96(sp)
    800010a0:	06d13423          	sd	a3,104(sp)
    800010a4:	06e13823          	sd	a4,112(sp)
    800010a8:	06f13c23          	sd	a5,120(sp)
    800010ac:	09013023          	sd	a6,128(sp)
    800010b0:	09113423          	sd	a7,136(sp)
    800010b4:	09213823          	sd	s2,144(sp)
    800010b8:	09313c23          	sd	s3,152(sp)
    800010bc:	0b413023          	sd	s4,160(sp)
    800010c0:	0b513423          	sd	s5,168(sp)
    800010c4:	0b613823          	sd	s6,176(sp)
    800010c8:	0b713c23          	sd	s7,184(sp)
    800010cc:	0d813023          	sd	s8,192(sp)
    800010d0:	0d913423          	sd	s9,200(sp)
    800010d4:	0da13823          	sd	s10,208(sp)
    800010d8:	0db13c23          	sd	s11,216(sp)
    800010dc:	0fc13023          	sd	t3,224(sp)
    800010e0:	0fd13423          	sd	t4,232(sp)
    800010e4:	0fe13823          	sd	t5,240(sp)
    800010e8:	0ff13c23          	sd	t6,248(sp)
    ld t0, 8(t0)
    800010ec:	0082b283          	ld	t0,8(t0)
    sd t0, 5 * 8(sp)
    800010f0:	02513423          	sd	t0,40(sp)

    addi s0, sp, 0
    800010f4:	00010413          	mv	s0,sp
    auipc t0, 0
    800010f8:	00000297          	auipc	t0,0x0
    addi t0, t0, 16
    800010fc:	01028293          	addi	t0,t0,16 # 80001108 <system_stack+0x9c>
    csrw sscratch, t0
    80001100:	14029073          	csrw	sscratch,t0

    call _ZN6Kernel16interruptHandlerEv
    80001104:	2e5010ef          	jal	ra,80002be8 <_ZN6Kernel16interruptHandlerEv>

    ld x0, 0 * 8(sp)
    80001108:	00013003          	ld	zero,0(sp)
    ld x1, 1 * 8(sp)
    8000110c:	00813083          	ld	ra,8(sp)
    ld t0, 2 * 8(sp)
    80001110:	01013283          	ld	t0,16(sp)
    .irp index,  3, 4, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
    sd x\index, \index * 8(sp)
    .endr
    80001114:	00313c23          	sd	gp,24(sp)
    80001118:	02413023          	sd	tp,32(sp)
    8000111c:	02613823          	sd	t1,48(sp)
    80001120:	02713c23          	sd	t2,56(sp)
    80001124:	04813023          	sd	s0,64(sp)
    80001128:	04913423          	sd	s1,72(sp)
    8000112c:	04a13823          	sd	a0,80(sp)
    80001130:	04b13c23          	sd	a1,88(sp)
    80001134:	06c13023          	sd	a2,96(sp)
    80001138:	06d13423          	sd	a3,104(sp)
    8000113c:	06e13823          	sd	a4,112(sp)
    80001140:	06f13c23          	sd	a5,120(sp)
    80001144:	09013023          	sd	a6,128(sp)
    80001148:	09113423          	sd	a7,136(sp)
    8000114c:	09213823          	sd	s2,144(sp)
    80001150:	09313c23          	sd	s3,152(sp)
    80001154:	0b413023          	sd	s4,160(sp)
    80001158:	0b513423          	sd	s5,168(sp)
    8000115c:	0b613823          	sd	s6,176(sp)
    80001160:	0b713c23          	sd	s7,184(sp)
    80001164:	0d813023          	sd	s8,192(sp)
    80001168:	0d913423          	sd	s9,200(sp)
    8000116c:	0da13823          	sd	s10,208(sp)
    80001170:	0db13c23          	sd	s11,216(sp)
    80001174:	0fc13023          	sd	t3,224(sp)
    80001178:	0fd13423          	sd	t4,232(sp)
    8000117c:	0fe13823          	sd	t5,240(sp)
    80001180:	0ff13c23          	sd	t6,248(sp)

    addi sp, sp, 256
    80001184:	10010113          	addi	sp,sp,256

    csrw sscratch, sp
    80001188:	14011073          	csrw	sscratch,sp

    addi sp, t0, 0
    8000118c:	00028113          	mv	sp,t0
    ld t0, 8(sp)
    80001190:	00813283          	ld	t0,8(sp)
    addi sp, sp, 16
    80001194:	01010113          	addi	sp,sp,16
    80001198:	10200073          	sret
    8000119c:	0000                	unimp
	...

00000000800011a0 <context_switch>:
.global context_switch
.type context_switch, @function
context_switch:
    sd ra, 0 * 8(a0)
    800011a0:	00153023          	sd	ra,0(a0) # 1000 <_entry-0x7ffff000>
    sd sp, 1 * 8(a0)
    800011a4:	00253423          	sd	sp,8(a0)


    ld ra, 0 * 8(a1)
    800011a8:	0005b083          	ld	ra,0(a1)
    ld sp, 1 * 8(a1)
    800011ac:	0085b103          	ld	sp,8(a1)
    ld t0, 2 * 8(a1)
    800011b0:	0105b283          	ld	t0,16(a1)

    beq t0, x0, continue
    800011b4:	00028663          	beqz	t0,800011c0 <continue>
    slli t0, t0, 8
    800011b8:	00829293          	slli	t0,t0,0x8
    csrs sstatus, t0
    800011bc:	1002a073          	csrs	sstatus,t0

00000000800011c0 <continue>:

    800011c0:	00008067          	ret

00000000800011c4 <_Z9mem_allocm>:


extern "C" uint64 system_call(Arguments* arg);

void* mem_alloc(size_t size)
{
    800011c4:	fa010113          	addi	sp,sp,-96
    800011c8:	04113c23          	sd	ra,88(sp)
    800011cc:	04813823          	sd	s0,80(sp)
    800011d0:	04913423          	sd	s1,72(sp)
    800011d4:	05213023          	sd	s2,64(sp)
    800011d8:	06010413          	addi	s0,sp,96
    800011dc:	00050493          	mv	s1,a0
    uint64 size_of_blocks = (size + MemoryAllocator::getSizeOfMetaData()) / MEM_BLOCK_SIZE;
    800011e0:	00001097          	auipc	ra,0x1
    800011e4:	1d0080e7          	jalr	464(ra) # 800023b0 <_ZN15MemoryAllocator17getSizeOfMetaDataEv>
    800011e8:	00950933          	add	s2,a0,s1
    800011ec:	00695913          	srli	s2,s2,0x6
    size_of_blocks += (size + MemoryAllocator::getSizeOfMetaData()) % MEM_BLOCK_SIZE ? 1: 0;
    800011f0:	00001097          	auipc	ra,0x1
    800011f4:	1c0080e7          	jalr	448(ra) # 800023b0 <_ZN15MemoryAllocator17getSizeOfMetaDataEv>
    800011f8:	00a484b3          	add	s1,s1,a0
    800011fc:	03f4f493          	andi	s1,s1,63
    80001200:	04048a63          	beqz	s1,80001254 <_Z9mem_allocm+0x90>
    80001204:	00100513          	li	a0,1
    80001208:	01250933          	add	s2,a0,s2
    Arguments arg = {KernelConfig::MEM_ALLOC, size_of_blocks, 0, 0, 0, 0, 0, 0};
    8000120c:	fa043823          	sd	zero,-80(s0)
    80001210:	fa043c23          	sd	zero,-72(s0)
    80001214:	fc043023          	sd	zero,-64(s0)
    80001218:	fc043423          	sd	zero,-56(s0)
    8000121c:	fc043823          	sd	zero,-48(s0)
    80001220:	fc043c23          	sd	zero,-40(s0)
    80001224:	00100793          	li	a5,1
    80001228:	faf43023          	sd	a5,-96(s0)
    8000122c:	fb243423          	sd	s2,-88(s0)
    return (void*) system_call(&arg);
    80001230:	fa040513          	addi	a0,s0,-96
    80001234:	00000097          	auipc	ra,0x0
    80001238:	dec080e7          	jalr	-532(ra) # 80001020 <system_call>
}
    8000123c:	05813083          	ld	ra,88(sp)
    80001240:	05013403          	ld	s0,80(sp)
    80001244:	04813483          	ld	s1,72(sp)
    80001248:	04013903          	ld	s2,64(sp)
    8000124c:	06010113          	addi	sp,sp,96
    80001250:	00008067          	ret
    size_of_blocks += (size + MemoryAllocator::getSizeOfMetaData()) % MEM_BLOCK_SIZE ? 1: 0;
    80001254:	00000513          	li	a0,0
    80001258:	fb1ff06f          	j	80001208 <_Z9mem_allocm+0x44>

000000008000125c <_Z8mem_freePv>:

int mem_free(void* obj)
{   Arguments arg = {KernelConfig::MEM_FREE, (uint64)obj, 0, 0, 0, 0, 0, 0};
    8000125c:	fb010113          	addi	sp,sp,-80
    80001260:	04113423          	sd	ra,72(sp)
    80001264:	04813023          	sd	s0,64(sp)
    80001268:	05010413          	addi	s0,sp,80
    8000126c:	fc043023          	sd	zero,-64(s0)
    80001270:	fc043423          	sd	zero,-56(s0)
    80001274:	fc043823          	sd	zero,-48(s0)
    80001278:	fc043c23          	sd	zero,-40(s0)
    8000127c:	fe043023          	sd	zero,-32(s0)
    80001280:	fe043423          	sd	zero,-24(s0)
    80001284:	00200793          	li	a5,2
    80001288:	faf43823          	sd	a5,-80(s0)
    8000128c:	faa43c23          	sd	a0,-72(s0)
    return (int) system_call(&arg);
    80001290:	fb040513          	addi	a0,s0,-80
    80001294:	00000097          	auipc	ra,0x0
    80001298:	d8c080e7          	jalr	-628(ra) # 80001020 <system_call>
}
    8000129c:	0005051b          	sext.w	a0,a0
    800012a0:	04813083          	ld	ra,72(sp)
    800012a4:	04013403          	ld	s0,64(sp)
    800012a8:	05010113          	addi	sp,sp,80
    800012ac:	00008067          	ret

00000000800012b0 <_Z18mem_get_free_spacev>:

size_t mem_get_free_space()
{
    800012b0:	fb010113          	addi	sp,sp,-80
    800012b4:	04113423          	sd	ra,72(sp)
    800012b8:	04813023          	sd	s0,64(sp)
    800012bc:	05010413          	addi	s0,sp,80
    Arguments arg = {KernelConfig::MEM_FREE_SPACE, 0, 0, 0, 0, 0, 0, 0};
    800012c0:	00300793          	li	a5,3
    800012c4:	faf43823          	sd	a5,-80(s0)
    800012c8:	fa043c23          	sd	zero,-72(s0)
    800012cc:	fc043023          	sd	zero,-64(s0)
    800012d0:	fc043423          	sd	zero,-56(s0)
    800012d4:	fc043823          	sd	zero,-48(s0)
    800012d8:	fc043c23          	sd	zero,-40(s0)
    800012dc:	fe043023          	sd	zero,-32(s0)
    800012e0:	fe043423          	sd	zero,-24(s0)
    return (size_t) system_call(&arg);
    800012e4:	fb040513          	addi	a0,s0,-80
    800012e8:	00000097          	auipc	ra,0x0
    800012ec:	d38080e7          	jalr	-712(ra) # 80001020 <system_call>
}
    800012f0:	04813083          	ld	ra,72(sp)
    800012f4:	04013403          	ld	s0,64(sp)
    800012f8:	05010113          	addi	sp,sp,80
    800012fc:	00008067          	ret

0000000080001300 <_Z26mem_get_largest_free_blockv>:
size_t mem_get_largest_free_block()
{
    80001300:	fb010113          	addi	sp,sp,-80
    80001304:	04113423          	sd	ra,72(sp)
    80001308:	04813023          	sd	s0,64(sp)
    8000130c:	05010413          	addi	s0,sp,80
    Arguments arg = {KernelConfig::LARGEST_FREE_BLOCK, 0, 0, 0, 0, 0, 0, 0};
    80001310:	00400793          	li	a5,4
    80001314:	faf43823          	sd	a5,-80(s0)
    80001318:	fa043c23          	sd	zero,-72(s0)
    8000131c:	fc043023          	sd	zero,-64(s0)
    80001320:	fc043423          	sd	zero,-56(s0)
    80001324:	fc043823          	sd	zero,-48(s0)
    80001328:	fc043c23          	sd	zero,-40(s0)
    8000132c:	fe043023          	sd	zero,-32(s0)
    80001330:	fe043423          	sd	zero,-24(s0)
    return (size_t) system_call(&arg);
    80001334:	fb040513          	addi	a0,s0,-80
    80001338:	00000097          	auipc	ra,0x0
    8000133c:	ce8080e7          	jalr	-792(ra) # 80001020 <system_call>
}
    80001340:	04813083          	ld	ra,72(sp)
    80001344:	04013403          	ld	s0,64(sp)
    80001348:	05010113          	addi	sp,sp,80
    8000134c:	00008067          	ret

0000000080001350 <_Z13thread_createPP3TCBPFvPvES2_>:

int thread_create(thread_t* handle, void(*start_routine)(void*), void* argOfRoutine)
{
    80001350:	f9010113          	addi	sp,sp,-112
    80001354:	06113423          	sd	ra,104(sp)
    80001358:	06813023          	sd	s0,96(sp)
    8000135c:	04913c23          	sd	s1,88(sp)
    80001360:	05213823          	sd	s2,80(sp)
    80001364:	05313423          	sd	s3,72(sp)
    80001368:	07010413          	addi	s0,sp,112
    8000136c:	00050993          	mv	s3,a0
    80001370:	00058913          	mv	s2,a1
    80001374:	00060493          	mv	s1,a2
    uint8* threadStack = (uint8*)mem_alloc(DEFAULT_STACK_SIZE);
    80001378:	00001537          	lui	a0,0x1
    8000137c:	00000097          	auipc	ra,0x0
    80001380:	e48080e7          	jalr	-440(ra) # 800011c4 <_Z9mem_allocm>
    if(threadStack == nullptr)
    80001384:	04050e63          	beqz	a0,800013e0 <_Z13thread_createPP3TCBPFvPvES2_+0x90>
    {
        return -1;
    }

    Arguments arg = {(uint64)KernelConfig::THREAD_CREATE, (uint64)handle, (uint64)start_routine, (uint64)argOfRoutine, (uint64)(&threadStack[DEFAULT_STACK_SIZE]), 0, 0, 0};
    80001388:	fa043c23          	sd	zero,-72(s0)
    8000138c:	fc043023          	sd	zero,-64(s0)
    80001390:	fc043423          	sd	zero,-56(s0)
    80001394:	01100793          	li	a5,17
    80001398:	f8f43823          	sd	a5,-112(s0)
    8000139c:	f9343c23          	sd	s3,-104(s0)
    800013a0:	fb243023          	sd	s2,-96(s0)
    800013a4:	fa943423          	sd	s1,-88(s0)
    800013a8:	000017b7          	lui	a5,0x1
    800013ac:	00f50533          	add	a0,a0,a5
    800013b0:	faa43823          	sd	a0,-80(s0)

    return (int) system_call(&arg);
    800013b4:	f9040513          	addi	a0,s0,-112
    800013b8:	00000097          	auipc	ra,0x0
    800013bc:	c68080e7          	jalr	-920(ra) # 80001020 <system_call>
    800013c0:	0005051b          	sext.w	a0,a0
}
    800013c4:	06813083          	ld	ra,104(sp)
    800013c8:	06013403          	ld	s0,96(sp)
    800013cc:	05813483          	ld	s1,88(sp)
    800013d0:	05013903          	ld	s2,80(sp)
    800013d4:	04813983          	ld	s3,72(sp)
    800013d8:	07010113          	addi	sp,sp,112
    800013dc:	00008067          	ret
        return -1;
    800013e0:	fff00513          	li	a0,-1
    800013e4:	fe1ff06f          	j	800013c4 <_Z13thread_createPP3TCBPFvPvES2_+0x74>

00000000800013e8 <_Z15thread_dispatchv>:

void thread_dispatch()
{
    800013e8:	fb010113          	addi	sp,sp,-80
    800013ec:	04113423          	sd	ra,72(sp)
    800013f0:	04813023          	sd	s0,64(sp)
    800013f4:	05010413          	addi	s0,sp,80
    Arguments arg = {KernelConfig::THREAD_DISPATCH, 0, 0, 0, 0, 0, 0, 0};
    800013f8:	01300793          	li	a5,19
    800013fc:	faf43823          	sd	a5,-80(s0)
    80001400:	fa043c23          	sd	zero,-72(s0)
    80001404:	fc043023          	sd	zero,-64(s0)
    80001408:	fc043423          	sd	zero,-56(s0)
    8000140c:	fc043823          	sd	zero,-48(s0)
    80001410:	fc043c23          	sd	zero,-40(s0)
    80001414:	fe043023          	sd	zero,-32(s0)
    80001418:	fe043423          	sd	zero,-24(s0)
    system_call(&arg);
    8000141c:	fb040513          	addi	a0,s0,-80
    80001420:	00000097          	auipc	ra,0x0
    80001424:	c00080e7          	jalr	-1024(ra) # 80001020 <system_call>
}
    80001428:	04813083          	ld	ra,72(sp)
    8000142c:	04013403          	ld	s0,64(sp)
    80001430:	05010113          	addi	sp,sp,80
    80001434:	00008067          	ret

0000000080001438 <_Z11thread_exitv>:

int thread_exit()
{
    80001438:	fb010113          	addi	sp,sp,-80
    8000143c:	04113423          	sd	ra,72(sp)
    80001440:	04813023          	sd	s0,64(sp)
    80001444:	05010413          	addi	s0,sp,80
    Arguments arg = {KernelConfig::THREAD_EXIT, 0, 0, 0, 0, 0, 0, 0};
    80001448:	01200793          	li	a5,18
    8000144c:	faf43823          	sd	a5,-80(s0)
    80001450:	fa043c23          	sd	zero,-72(s0)
    80001454:	fc043023          	sd	zero,-64(s0)
    80001458:	fc043423          	sd	zero,-56(s0)
    8000145c:	fc043823          	sd	zero,-48(s0)
    80001460:	fc043c23          	sd	zero,-40(s0)
    80001464:	fe043023          	sd	zero,-32(s0)
    80001468:	fe043423          	sd	zero,-24(s0)
    return (int) system_call(&arg);
    8000146c:	fb040513          	addi	a0,s0,-80
    80001470:	00000097          	auipc	ra,0x0
    80001474:	bb0080e7          	jalr	-1104(ra) # 80001020 <system_call>
}
    80001478:	0005051b          	sext.w	a0,a0
    8000147c:	04813083          	ld	ra,72(sp)
    80001480:	04013403          	ld	s0,64(sp)
    80001484:	05010113          	addi	sp,sp,80
    80001488:	00008067          	ret

000000008000148c <_Z8sem_openPP10KSemaphorej>:

int sem_open(sem_t* handle, unsigned init)
{
    8000148c:	fb010113          	addi	sp,sp,-80
    80001490:	04113423          	sd	ra,72(sp)
    80001494:	04813023          	sd	s0,64(sp)
    80001498:	05010413          	addi	s0,sp,80
    Arguments arg = {(uint64)KernelConfig::SEMAPHORE_OPEN, (uint64)handle, (uint64)init, 0, 0, 0, 0, 0};
    8000149c:	fc043423          	sd	zero,-56(s0)
    800014a0:	fc043823          	sd	zero,-48(s0)
    800014a4:	fc043c23          	sd	zero,-40(s0)
    800014a8:	fe043023          	sd	zero,-32(s0)
    800014ac:	fe043423          	sd	zero,-24(s0)
    800014b0:	02100793          	li	a5,33
    800014b4:	faf43823          	sd	a5,-80(s0)
    800014b8:	faa43c23          	sd	a0,-72(s0)
    800014bc:	02059593          	slli	a1,a1,0x20
    800014c0:	0205d593          	srli	a1,a1,0x20
    800014c4:	fcb43023          	sd	a1,-64(s0)
    return (int) system_call(&arg);
    800014c8:	fb040513          	addi	a0,s0,-80
    800014cc:	00000097          	auipc	ra,0x0
    800014d0:	b54080e7          	jalr	-1196(ra) # 80001020 <system_call>
}
    800014d4:	0005051b          	sext.w	a0,a0
    800014d8:	04813083          	ld	ra,72(sp)
    800014dc:	04013403          	ld	s0,64(sp)
    800014e0:	05010113          	addi	sp,sp,80
    800014e4:	00008067          	ret

00000000800014e8 <_Z9sem_closeP10KSemaphore>:

int sem_close(sem_t handle)
{
    800014e8:	fb010113          	addi	sp,sp,-80
    800014ec:	04113423          	sd	ra,72(sp)
    800014f0:	04813023          	sd	s0,64(sp)
    800014f4:	05010413          	addi	s0,sp,80
    Arguments arg = {(uint64)KernelConfig::SEMAPHORE_CLOSE, (uint64)handle, 0, 0, 0, 0, 0, 0};
    800014f8:	fc043023          	sd	zero,-64(s0)
    800014fc:	fc043423          	sd	zero,-56(s0)
    80001500:	fc043823          	sd	zero,-48(s0)
    80001504:	fc043c23          	sd	zero,-40(s0)
    80001508:	fe043023          	sd	zero,-32(s0)
    8000150c:	fe043423          	sd	zero,-24(s0)
    80001510:	02200793          	li	a5,34
    80001514:	faf43823          	sd	a5,-80(s0)
    80001518:	faa43c23          	sd	a0,-72(s0)
    return (int) system_call(&arg);
    8000151c:	fb040513          	addi	a0,s0,-80
    80001520:	00000097          	auipc	ra,0x0
    80001524:	b00080e7          	jalr	-1280(ra) # 80001020 <system_call>
}
    80001528:	0005051b          	sext.w	a0,a0
    8000152c:	04813083          	ld	ra,72(sp)
    80001530:	04013403          	ld	s0,64(sp)
    80001534:	05010113          	addi	sp,sp,80
    80001538:	00008067          	ret

000000008000153c <_Z8sem_waitP10KSemaphore>:

int sem_wait(sem_t handle)
{
    8000153c:	fb010113          	addi	sp,sp,-80
    80001540:	04113423          	sd	ra,72(sp)
    80001544:	04813023          	sd	s0,64(sp)
    80001548:	05010413          	addi	s0,sp,80
    Arguments arg = {(uint64)KernelConfig::SEMAPHORE_WAIT, (uint64)handle, 0, 0, 0, 0, 0, 0};
    8000154c:	fc043023          	sd	zero,-64(s0)
    80001550:	fc043423          	sd	zero,-56(s0)
    80001554:	fc043823          	sd	zero,-48(s0)
    80001558:	fc043c23          	sd	zero,-40(s0)
    8000155c:	fe043023          	sd	zero,-32(s0)
    80001560:	fe043423          	sd	zero,-24(s0)
    80001564:	02300793          	li	a5,35
    80001568:	faf43823          	sd	a5,-80(s0)
    8000156c:	faa43c23          	sd	a0,-72(s0)
    return (int) system_call(&arg);
    80001570:	fb040513          	addi	a0,s0,-80
    80001574:	00000097          	auipc	ra,0x0
    80001578:	aac080e7          	jalr	-1364(ra) # 80001020 <system_call>
}
    8000157c:	0005051b          	sext.w	a0,a0
    80001580:	04813083          	ld	ra,72(sp)
    80001584:	04013403          	ld	s0,64(sp)
    80001588:	05010113          	addi	sp,sp,80
    8000158c:	00008067          	ret

0000000080001590 <_Z10sem_signalP10KSemaphore>:

int sem_signal(sem_t handle)
{
    80001590:	fb010113          	addi	sp,sp,-80
    80001594:	04113423          	sd	ra,72(sp)
    80001598:	04813023          	sd	s0,64(sp)
    8000159c:	05010413          	addi	s0,sp,80
    Arguments arg = {(uint64)KernelConfig::SEMAPHORE_SIGNAL, (uint64)handle, 0, 0, 0, 0, 0, 0};
    800015a0:	fc043023          	sd	zero,-64(s0)
    800015a4:	fc043423          	sd	zero,-56(s0)
    800015a8:	fc043823          	sd	zero,-48(s0)
    800015ac:	fc043c23          	sd	zero,-40(s0)
    800015b0:	fe043023          	sd	zero,-32(s0)
    800015b4:	fe043423          	sd	zero,-24(s0)
    800015b8:	02400793          	li	a5,36
    800015bc:	faf43823          	sd	a5,-80(s0)
    800015c0:	faa43c23          	sd	a0,-72(s0)
    return (int) system_call(&arg);
    800015c4:	fb040513          	addi	a0,s0,-80
    800015c8:	00000097          	auipc	ra,0x0
    800015cc:	a58080e7          	jalr	-1448(ra) # 80001020 <system_call>
}
    800015d0:	0005051b          	sext.w	a0,a0
    800015d4:	04813083          	ld	ra,72(sp)
    800015d8:	04013403          	ld	s0,64(sp)
    800015dc:	05010113          	addi	sp,sp,80
    800015e0:	00008067          	ret

00000000800015e4 <_Z10time_sleepm>:

int time_sleep(time_t time_to_sleep)
{
    800015e4:	fb010113          	addi	sp,sp,-80
    800015e8:	04113423          	sd	ra,72(sp)
    800015ec:	04813023          	sd	s0,64(sp)
    800015f0:	05010413          	addi	s0,sp,80
    Arguments arg = {(uint64)KernelConfig::TIME_SLEEP, (uint64)time_to_sleep, 0, 0, 0, 0, 0, 0};
    800015f4:	fc043023          	sd	zero,-64(s0)
    800015f8:	fc043423          	sd	zero,-56(s0)
    800015fc:	fc043823          	sd	zero,-48(s0)
    80001600:	fc043c23          	sd	zero,-40(s0)
    80001604:	fe043023          	sd	zero,-32(s0)
    80001608:	fe043423          	sd	zero,-24(s0)
    8000160c:	03100793          	li	a5,49
    80001610:	faf43823          	sd	a5,-80(s0)
    80001614:	faa43c23          	sd	a0,-72(s0)
    return (int) system_call(&arg);
    80001618:	fb040513          	addi	a0,s0,-80
    8000161c:	00000097          	auipc	ra,0x0
    80001620:	a04080e7          	jalr	-1532(ra) # 80001020 <system_call>
}
    80001624:	0005051b          	sext.w	a0,a0
    80001628:	04813083          	ld	ra,72(sp)
    8000162c:	04013403          	ld	s0,64(sp)
    80001630:	05010113          	addi	sp,sp,80
    80001634:	00008067          	ret

0000000080001638 <_Z4getcv>:
char getc()
{
    80001638:	fb010113          	addi	sp,sp,-80
    8000163c:	04113423          	sd	ra,72(sp)
    80001640:	04813023          	sd	s0,64(sp)
    80001644:	05010413          	addi	s0,sp,80
    Arguments arg = {(uint64)KernelConfig::GETC, 0, 0, 0, 0, 0, 0, 0};
    80001648:	04100793          	li	a5,65
    8000164c:	faf43823          	sd	a5,-80(s0)
    80001650:	fa043c23          	sd	zero,-72(s0)
    80001654:	fc043023          	sd	zero,-64(s0)
    80001658:	fc043423          	sd	zero,-56(s0)
    8000165c:	fc043823          	sd	zero,-48(s0)
    80001660:	fc043c23          	sd	zero,-40(s0)
    80001664:	fe043023          	sd	zero,-32(s0)
    80001668:	fe043423          	sd	zero,-24(s0)
    return (char) system_call(&arg);
    8000166c:	fb040513          	addi	a0,s0,-80
    80001670:	00000097          	auipc	ra,0x0
    80001674:	9b0080e7          	jalr	-1616(ra) # 80001020 <system_call>
}
    80001678:	0ff57513          	andi	a0,a0,255
    8000167c:	04813083          	ld	ra,72(sp)
    80001680:	04013403          	ld	s0,64(sp)
    80001684:	05010113          	addi	sp,sp,80
    80001688:	00008067          	ret

000000008000168c <_Z4putcc>:

void putc(char c)
{
    8000168c:	fb010113          	addi	sp,sp,-80
    80001690:	04113423          	sd	ra,72(sp)
    80001694:	04813023          	sd	s0,64(sp)
    80001698:	05010413          	addi	s0,sp,80
    Arguments arg = {(uint64)KernelConfig::PUTC, (uint64) c, 0, 0, 0, 0, 0, 0};
    8000169c:	fc043023          	sd	zero,-64(s0)
    800016a0:	fc043423          	sd	zero,-56(s0)
    800016a4:	fc043823          	sd	zero,-48(s0)
    800016a8:	fc043c23          	sd	zero,-40(s0)
    800016ac:	fe043023          	sd	zero,-32(s0)
    800016b0:	fe043423          	sd	zero,-24(s0)
    800016b4:	04200793          	li	a5,66
    800016b8:	faf43823          	sd	a5,-80(s0)
    800016bc:	faa43c23          	sd	a0,-72(s0)
    system_call(&arg);
    800016c0:	fb040513          	addi	a0,s0,-80
    800016c4:	00000097          	auipc	ra,0x0
    800016c8:	95c080e7          	jalr	-1700(ra) # 80001020 <system_call>
    800016cc:	04813083          	ld	ra,72(sp)
    800016d0:	04013403          	ld	s0,64(sp)
    800016d4:	05010113          	addi	sp,sp,80
    800016d8:	00008067          	ret

00000000800016dc <_Z41__static_initialization_and_destruction_0ii>:
        TCB::setRunningThread(Scheduler::get());
        oldThread->resetState();
        context_switch(oldThread->getContext(), TCB::getRunningThread()->getContext());
    }

}
    800016dc:	00100793          	li	a5,1
    800016e0:	00f50463          	beq	a0,a5,800016e8 <_Z41__static_initialization_and_destruction_0ii+0xc>
    800016e4:	00008067          	ret
    800016e8:	000107b7          	lui	a5,0x10
    800016ec:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    800016f0:	fef59ae3          	bne	a1,a5,800016e4 <_Z41__static_initialization_and_destruction_0ii+0x8>
    800016f4:	fe010113          	addi	sp,sp,-32
    800016f8:	00113c23          	sd	ra,24(sp)
    800016fc:	00813823          	sd	s0,16(sp)
    80001700:	00913423          	sd	s1,8(sp)
    80001704:	01213023          	sd	s2,0(sp)
    80001708:	02010413          	addi	s0,sp,32
Buffer<char, KernelConfig::SIZE_INPUT_BUFFER>* KConsole::inputBuffer = new Buffer<char, KernelConfig::SIZE_INPUT_BUFFER>();
    8000170c:	33800513          	li	a0,824
    80001710:	00000097          	auipc	ra,0x0
    80001714:	3f8080e7          	jalr	1016(ra) # 80001b08 <_ZN6BufferIcLm100EEnwEm>
    80001718:	00050913          	mv	s2,a0
    8000171c:	00000097          	auipc	ra,0x0
    80001720:	428080e7          	jalr	1064(ra) # 80001b44 <_ZN6BufferIcLm100EEC1Ev>
    80001724:	00006497          	auipc	s1,0x6
    80001728:	c4c48493          	addi	s1,s1,-948 # 80007370 <_ZN8KConsole11inputBufferE>
    8000172c:	0124b023          	sd	s2,0(s1)
Buffer<char, KernelConfig::SIZE_OUTPUT_BUFFER>* KConsole::outputBuffer = new Buffer<char, KernelConfig::SIZE_OUTPUT_BUFFER>();
    80001730:	33800513          	li	a0,824
    80001734:	00000097          	auipc	ra,0x0
    80001738:	3d4080e7          	jalr	980(ra) # 80001b08 <_ZN6BufferIcLm100EEnwEm>
    8000173c:	00050913          	mv	s2,a0
    80001740:	00000097          	auipc	ra,0x0
    80001744:	404080e7          	jalr	1028(ra) # 80001b44 <_ZN6BufferIcLm100EEC1Ev>
    80001748:	0124b423          	sd	s2,8(s1)
Queue<TCB>* KConsole::inputWaitQueue = new Queue<TCB>();
    8000174c:	01000513          	li	a0,16
    80001750:	00000097          	auipc	ra,0x0
    80001754:	438080e7          	jalr	1080(ra) # 80001b88 <_ZN5QueueI3TCBEnwEm>
    80001758:	00053023          	sd	zero,0(a0) # 1000 <_entry-0x7ffff000>
    8000175c:	00053423          	sd	zero,8(a0)
    80001760:	00a4b823          	sd	a0,16(s1)
Queue<TCB>* KConsole::outputWaitQueue = new Queue<TCB>();
    80001764:	01000513          	li	a0,16
    80001768:	00000097          	auipc	ra,0x0
    8000176c:	420080e7          	jalr	1056(ra) # 80001b88 <_ZN5QueueI3TCBEnwEm>
    80001770:	00053023          	sd	zero,0(a0)
    80001774:	00053423          	sd	zero,8(a0)
    80001778:	00a4bc23          	sd	a0,24(s1)
}
    8000177c:	01813083          	ld	ra,24(sp)
    80001780:	01013403          	ld	s0,16(sp)
    80001784:	00813483          	ld	s1,8(sp)
    80001788:	00013903          	ld	s2,0(sp)
    8000178c:	02010113          	addi	sp,sp,32
    80001790:	00008067          	ret

0000000080001794 <_ZN8KConsole25addThreadToInputWaitQueueEP3TCB>:
{
    80001794:	ff010113          	addi	sp,sp,-16
    80001798:	00113423          	sd	ra,8(sp)
    8000179c:	00813023          	sd	s0,0(sp)
    800017a0:	01010413          	addi	s0,sp,16
    800017a4:	00050593          	mv	a1,a0
    inputWaitQueue->append(thread);
    800017a8:	00006517          	auipc	a0,0x6
    800017ac:	bd853503          	ld	a0,-1064(a0) # 80007380 <_ZN8KConsole14inputWaitQueueE>
    800017b0:	00000097          	auipc	ra,0x0
    800017b4:	414080e7          	jalr	1044(ra) # 80001bc4 <_ZN5QueueI3TCBE6appendEPS0_>
}
    800017b8:	00813083          	ld	ra,8(sp)
    800017bc:	00013403          	ld	s0,0(sp)
    800017c0:	01010113          	addi	sp,sp,16
    800017c4:	00008067          	ret

00000000800017c8 <_ZN8KConsole26addThreadToOutputWaitQueueEP3TCB>:
{
    800017c8:	ff010113          	addi	sp,sp,-16
    800017cc:	00113423          	sd	ra,8(sp)
    800017d0:	00813023          	sd	s0,0(sp)
    800017d4:	01010413          	addi	s0,sp,16
    800017d8:	00050593          	mv	a1,a0
    outputWaitQueue->append(thread);
    800017dc:	00006517          	auipc	a0,0x6
    800017e0:	bac53503          	ld	a0,-1108(a0) # 80007388 <_ZN8KConsole15outputWaitQueueE>
    800017e4:	00000097          	auipc	ra,0x0
    800017e8:	3e0080e7          	jalr	992(ra) # 80001bc4 <_ZN5QueueI3TCBE6appendEPS0_>
}
    800017ec:	00813083          	ld	ra,8(sp)
    800017f0:	00013403          	ld	s0,0(sp)
    800017f4:	01010113          	addi	sp,sp,16
    800017f8:	00008067          	ret

00000000800017fc <_ZN8KConsole30removeThreadFromInputWaitQueueEv>:
{
    800017fc:	ff010113          	addi	sp,sp,-16
    80001800:	00113423          	sd	ra,8(sp)
    80001804:	00813023          	sd	s0,0(sp)
    80001808:	01010413          	addi	s0,sp,16
    TCB* oldThread = outputWaitQueue->take();
    8000180c:	00006517          	auipc	a0,0x6
    80001810:	b7c53503          	ld	a0,-1156(a0) # 80007388 <_ZN8KConsole15outputWaitQueueE>
    80001814:	00000097          	auipc	ra,0x0
    80001818:	3e4080e7          	jalr	996(ra) # 80001bf8 <_ZN5QueueI3TCBE4takeEv>
    if(oldThread)
    8000181c:	00050863          	beqz	a0,8000182c <_ZN8KConsole30removeThreadFromInputWaitQueueEv+0x30>
    void setTimeToSleep(size_t time) { timeToSleep = time; }

    void decrementTimeToSleep() { timeToSleep--; };
    void addThreadToState(TCB* newThread) { state = newThread; }
    TCB* getState() const { return state; }
    void resetState() {state = nullptr; }
    80001820:	04053423          	sd	zero,72(a0)
        Scheduler::put(oldThread);
    80001824:	00000097          	auipc	ra,0x0
    80001828:	50c080e7          	jalr	1292(ra) # 80001d30 <_ZN9Scheduler3putEP3TCB>
}
    8000182c:	00813083          	ld	ra,8(sp)
    80001830:	00013403          	ld	s0,0(sp)
    80001834:	01010113          	addi	sp,sp,16
    80001838:	00008067          	ret

000000008000183c <_ZN8KConsole31removeThreadFromOutputWaitQueueEv>:
{
    8000183c:	ff010113          	addi	sp,sp,-16
    80001840:	00113423          	sd	ra,8(sp)
    80001844:	00813023          	sd	s0,0(sp)
    80001848:	01010413          	addi	s0,sp,16
    TCB* oldThread = inputWaitQueue->take();
    8000184c:	00006517          	auipc	a0,0x6
    80001850:	b3453503          	ld	a0,-1228(a0) # 80007380 <_ZN8KConsole14inputWaitQueueE>
    80001854:	00000097          	auipc	ra,0x0
    80001858:	3a4080e7          	jalr	932(ra) # 80001bf8 <_ZN5QueueI3TCBE4takeEv>
    if(oldThread)
    8000185c:	00050863          	beqz	a0,8000186c <_ZN8KConsole31removeThreadFromOutputWaitQueueEv+0x30>
    80001860:	04053423          	sd	zero,72(a0)
        Scheduler::put(oldThread);
    80001864:	00000097          	auipc	ra,0x0
    80001868:	4cc080e7          	jalr	1228(ra) # 80001d30 <_ZN9Scheduler3putEP3TCB>
}
    8000186c:	00813083          	ld	ra,8(sp)
    80001870:	00013403          	ld	s0,0(sp)
    80001874:	01010113          	addi	sp,sp,16
    80001878:	00008067          	ret

000000008000187c <_ZN8KConsole22getCharFromInputBufferEv>:
{
    8000187c:	ff010113          	addi	sp,sp,-16
    80001880:	00113423          	sd	ra,8(sp)
    80001884:	00813023          	sd	s0,0(sp)
    80001888:	01010413          	addi	s0,sp,16
    return *(inputBuffer->take());
    8000188c:	00006517          	auipc	a0,0x6
    80001890:	ae453503          	ld	a0,-1308(a0) # 80007370 <_ZN8KConsole11inputBufferE>
    80001894:	00000097          	auipc	ra,0x0
    80001898:	39c080e7          	jalr	924(ra) # 80001c30 <_ZN6BufferIcLm100EE4takeEv>
}
    8000189c:	00054503          	lbu	a0,0(a0)
    800018a0:	00813083          	ld	ra,8(sp)
    800018a4:	00013403          	ld	s0,0(sp)
    800018a8:	01010113          	addi	sp,sp,16
    800018ac:	00008067          	ret

00000000800018b0 <_ZN8KConsole19consumeOutputBufferEPv>:
{
    800018b0:	fd010113          	addi	sp,sp,-48
    800018b4:	02113423          	sd	ra,40(sp)
    800018b8:	02813023          	sd	s0,32(sp)
    800018bc:	00913c23          	sd	s1,24(sp)
    800018c0:	01213823          	sd	s2,16(sp)
    800018c4:	03010413          	addi	s0,sp,48
    800018c8:	0400006f          	j	80001908 <_ZN8KConsole19consumeOutputBufferEPv+0x58>
        plic_complete(numOfDevice);
    800018cc:	fd842503          	lw	a0,-40(s0)
    800018d0:	0005051b          	sext.w	a0,a0
    800018d4:	00003097          	auipc	ra,0x3
    800018d8:	838080e7          	jalr	-1992(ra) # 8000410c <plic_complete>
    void setSemaphoreOnWait (KSemaphore* semaphore) { waitOnSemaphore = semaphore; }
    KSemaphore* getSemaphoreOnWait() const { return waitOnSemaphore; }
    void resetSemaphoreOnWait() { waitOnSemaphore = nullptr; }
    static void dispatch();

    static TCB* getRunningThread() { return running; }
    800018dc:	00006917          	auipc	s2,0x6
    800018e0:	a1493903          	ld	s2,-1516(s2) # 800072f0 <_GLOBAL_OFFSET_TABLE_+0x60>
    800018e4:	00093483          	ld	s1,0(s2)
        TCB::setRunningThread(Scheduler::get());
    800018e8:	00000097          	auipc	ra,0x0
    800018ec:	47c080e7          	jalr	1148(ra) # 80001d64 <_ZN9Scheduler3getEv>
    static void setRunningThread(TCB* newRunningThread) { running = newRunningThread; }
    800018f0:	00a93023          	sd	a0,0(s2)
    void resetState() {state = nullptr; }
    800018f4:	0404b423          	sd	zero,72(s1)
        context_switch(oldThread->getContext(), TCB::getRunningThread()->getContext());
    800018f8:	00850593          	addi	a1,a0,8
    800018fc:	00848513          	addi	a0,s1,8
    80001900:	00000097          	auipc	ra,0x0
    80001904:	8a0080e7          	jalr	-1888(ra) # 800011a0 <context_switch>
        volatile int numOfDevice = plic_claim();
    80001908:	00002097          	auipc	ra,0x2
    8000190c:	7cc080e7          	jalr	1996(ra) # 800040d4 <plic_claim>
    80001910:	fca42c23          	sw	a0,-40(s0)
            data = *(outputBuffer->take());
    80001914:	00006517          	auipc	a0,0x6
    80001918:	a6453503          	ld	a0,-1436(a0) # 80007378 <_ZN8KConsole12outputBufferE>
    8000191c:	00000097          	auipc	ra,0x0
    80001920:	314080e7          	jalr	788(ra) # 80001c30 <_ZN6BufferIcLm100EE4takeEv>
    80001924:	00054783          	lbu	a5,0(a0)
    80001928:	fcf40fa3          	sb	a5,-33(s0)
            __asm__ volatile("sb %[regData], 0(%[address])":: [regData]"r"(data), [address]"r"(CONSOLE_TX_DATA));
    8000192c:	fdf44783          	lbu	a5,-33(s0)
    80001930:	00006717          	auipc	a4,0x6
    80001934:	98873703          	ld	a4,-1656(a4) # 800072b8 <_GLOBAL_OFFSET_TABLE_+0x28>
    80001938:	00073703          	ld	a4,0(a4)
    8000193c:	00f70023          	sb	a5,0(a4)
            __asm__ volatile("lb %[status], 0(%[address])": [status] "=r"(statusReg): [address] "r"(CONSOLE_STATUS));
    80001940:	00006797          	auipc	a5,0x6
    80001944:	9607b783          	ld	a5,-1696(a5) # 800072a0 <_GLOBAL_OFFSET_TABLE_+0x10>
    80001948:	0007b783          	ld	a5,0(a5)
    8000194c:	00078783          	lb	a5,0(a5)
    80001950:	fcf40f23          	sb	a5,-34(s0)
            removeThreadFromOutputWaitQueue();
    80001954:	00000097          	auipc	ra,0x0
    80001958:	ee8080e7          	jalr	-280(ra) # 8000183c <_ZN8KConsole31removeThreadFromOutputWaitQueueEv>
        } while ((statusReg & CONSOLE_TX_STATUS_BIT) && !outputBuffer->isBufferEmpty());
    8000195c:	fde44783          	lbu	a5,-34(s0)
    80001960:	0ff7f793          	andi	a5,a5,255
    80001964:	0207f793          	andi	a5,a5,32
    80001968:	f60782e3          	beqz	a5,800018cc <_ZN8KConsole19consumeOutputBufferEPv+0x1c>
    8000196c:	00006517          	auipc	a0,0x6
    80001970:	a0c53503          	ld	a0,-1524(a0) # 80007378 <_ZN8KConsole12outputBufferE>
    80001974:	00000097          	auipc	ra,0x0
    80001978:	150080e7          	jalr	336(ra) # 80001ac4 <_ZNK6BufferIcLm100EE13isBufferEmptyEv>
    8000197c:	f8050ce3          	beqz	a0,80001914 <_ZN8KConsole19consumeOutputBufferEPv+0x64>
    80001980:	f4dff06f          	j	800018cc <_ZN8KConsole19consumeOutputBufferEPv+0x1c>

0000000080001984 <_ZN8KConsole21addCharToOutputBufferEc>:
{
    80001984:	fe010113          	addi	sp,sp,-32
    80001988:	00113c23          	sd	ra,24(sp)
    8000198c:	00813823          	sd	s0,16(sp)
    80001990:	02010413          	addi	s0,sp,32
    80001994:	fea407a3          	sb	a0,-17(s0)
    outputBuffer->append(&c);
    80001998:	fef40593          	addi	a1,s0,-17
    8000199c:	00006517          	auipc	a0,0x6
    800019a0:	9dc53503          	ld	a0,-1572(a0) # 80007378 <_ZN8KConsole12outputBufferE>
    800019a4:	00000097          	auipc	ra,0x0
    800019a8:	2e0080e7          	jalr	736(ra) # 80001c84 <_ZN6BufferIcLm100EE6appendEPc>
}
    800019ac:	01813083          	ld	ra,24(sp)
    800019b0:	01013403          	ld	s0,16(sp)
    800019b4:	02010113          	addi	sp,sp,32
    800019b8:	00008067          	ret

00000000800019bc <_ZN8KConsole18produceInputBufferEPv>:
{
    800019bc:	fd010113          	addi	sp,sp,-48
    800019c0:	02113423          	sd	ra,40(sp)
    800019c4:	02813023          	sd	s0,32(sp)
    800019c8:	00913c23          	sd	s1,24(sp)
    800019cc:	01213823          	sd	s2,16(sp)
    800019d0:	03010413          	addi	s0,sp,48
    800019d4:	0400006f          	j	80001a14 <_ZN8KConsole18produceInputBufferEPv+0x58>
        plic_complete(numOfDevice);
    800019d8:	fd842503          	lw	a0,-40(s0)
    800019dc:	0005051b          	sext.w	a0,a0
    800019e0:	00002097          	auipc	ra,0x2
    800019e4:	72c080e7          	jalr	1836(ra) # 8000410c <plic_complete>
    static TCB* getRunningThread() { return running; }
    800019e8:	00006917          	auipc	s2,0x6
    800019ec:	90893903          	ld	s2,-1784(s2) # 800072f0 <_GLOBAL_OFFSET_TABLE_+0x60>
    800019f0:	00093483          	ld	s1,0(s2)
        TCB::setRunningThread(Scheduler::get());
    800019f4:	00000097          	auipc	ra,0x0
    800019f8:	370080e7          	jalr	880(ra) # 80001d64 <_ZN9Scheduler3getEv>
    static void setRunningThread(TCB* newRunningThread) { running = newRunningThread; }
    800019fc:	00a93023          	sd	a0,0(s2)
    void resetState() {state = nullptr; }
    80001a00:	0404b423          	sd	zero,72(s1)
        context_switch(oldThread->getContext(), TCB::getRunningThread()->getContext());
    80001a04:	00850593          	addi	a1,a0,8
    80001a08:	00848513          	addi	a0,s1,8
    80001a0c:	fffff097          	auipc	ra,0xfffff
    80001a10:	794080e7          	jalr	1940(ra) # 800011a0 <context_switch>
        volatile int numOfDevice = plic_claim();
    80001a14:	00002097          	auipc	ra,0x2
    80001a18:	6c0080e7          	jalr	1728(ra) # 800040d4 <plic_claim>
    80001a1c:	fca42c23          	sw	a0,-40(s0)
            __asm__ volatile("lb %[regData], 0(%[address])" : [regData]"=r"(data): [address]"r"(CONSOLE_RX_DATA));
    80001a20:	00006797          	auipc	a5,0x6
    80001a24:	8787b783          	ld	a5,-1928(a5) # 80007298 <_GLOBAL_OFFSET_TABLE_+0x8>
    80001a28:	0007b783          	ld	a5,0(a5)
    80001a2c:	00078783          	lb	a5,0(a5)
    80001a30:	fcf40f23          	sb	a5,-34(s0)
            char c = data;
    80001a34:	fde44783          	lbu	a5,-34(s0)
    80001a38:	fcf40ba3          	sb	a5,-41(s0)
            inputBuffer->append(&c);
    80001a3c:	fd740593          	addi	a1,s0,-41
    80001a40:	00006517          	auipc	a0,0x6
    80001a44:	93053503          	ld	a0,-1744(a0) # 80007370 <_ZN8KConsole11inputBufferE>
    80001a48:	00000097          	auipc	ra,0x0
    80001a4c:	23c080e7          	jalr	572(ra) # 80001c84 <_ZN6BufferIcLm100EE6appendEPc>
            __asm__ volatile("lb %[status], 0(%[address])": [status] "=r"(statusReg): [address] "r"(CONSOLE_STATUS));
    80001a50:	00006797          	auipc	a5,0x6
    80001a54:	8507b783          	ld	a5,-1968(a5) # 800072a0 <_GLOBAL_OFFSET_TABLE_+0x10>
    80001a58:	0007b783          	ld	a5,0(a5)
    80001a5c:	00078783          	lb	a5,0(a5)
    80001a60:	fcf40fa3          	sb	a5,-33(s0)
            removeThreadFromInputWaitQueue();
    80001a64:	00000097          	auipc	ra,0x0
    80001a68:	d98080e7          	jalr	-616(ra) # 800017fc <_ZN8KConsole30removeThreadFromInputWaitQueueEv>
        } while ((statusReg & CONSOLE_RX_STATUS_BIT) && !inputBuffer->isBufferFull());
    80001a6c:	fdf44783          	lbu	a5,-33(s0)
    80001a70:	0017f793          	andi	a5,a5,1
    80001a74:	f60782e3          	beqz	a5,800019d8 <_ZN8KConsole18produceInputBufferEPv+0x1c>
    80001a78:	00006517          	auipc	a0,0x6
    80001a7c:	8f853503          	ld	a0,-1800(a0) # 80007370 <_ZN8KConsole11inputBufferE>
    80001a80:	00000097          	auipc	ra,0x0
    80001a84:	064080e7          	jalr	100(ra) # 80001ae4 <_ZNK6BufferIcLm100EE12isBufferFullEv>
    80001a88:	f8050ce3          	beqz	a0,80001a20 <_ZN8KConsole18produceInputBufferEPv+0x64>
    80001a8c:	f4dff06f          	j	800019d8 <_ZN8KConsole18produceInputBufferEPv+0x1c>

0000000080001a90 <_GLOBAL__sub_I__ZN8KConsole11inputBufferE>:
}
    80001a90:	ff010113          	addi	sp,sp,-16
    80001a94:	00113423          	sd	ra,8(sp)
    80001a98:	00813023          	sd	s0,0(sp)
    80001a9c:	01010413          	addi	s0,sp,16
    80001aa0:	000105b7          	lui	a1,0x10
    80001aa4:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    80001aa8:	00100513          	li	a0,1
    80001aac:	00000097          	auipc	ra,0x0
    80001ab0:	c30080e7          	jalr	-976(ra) # 800016dc <_Z41__static_initialization_and_destruction_0ii>
    80001ab4:	00813083          	ld	ra,8(sp)
    80001ab8:	00013403          	ld	s0,0(sp)
    80001abc:	01010113          	addi	sp,sp,16
    80001ac0:	00008067          	ret

0000000080001ac4 <_ZNK6BufferIcLm100EE13isBufferEmptyEv>:
    return tempElem;

}

template<typename T, size_t numOfElements>
bool Buffer<T, numOfElements>::isBufferEmpty() const
    80001ac4:	ff010113          	addi	sp,sp,-16
    80001ac8:	00813423          	sd	s0,8(sp)
    80001acc:	01010413          	addi	s0,sp,16
{
    return count == 0;
    80001ad0:	33053503          	ld	a0,816(a0)
}
    80001ad4:	00153513          	seqz	a0,a0
    80001ad8:	00813403          	ld	s0,8(sp)
    80001adc:	01010113          	addi	sp,sp,16
    80001ae0:	00008067          	ret

0000000080001ae4 <_ZNK6BufferIcLm100EE12isBufferFullEv>:
template<typename T, size_t numOfElements>
bool Buffer<T, numOfElements>::isBufferFull() const
    80001ae4:	ff010113          	addi	sp,sp,-16
    80001ae8:	00813423          	sd	s0,8(sp)
    80001aec:	01010413          	addi	s0,sp,16
{
    return count == numOfElements;
    80001af0:	33053503          	ld	a0,816(a0)
    80001af4:	f9c50513          	addi	a0,a0,-100
}
    80001af8:	00153513          	seqz	a0,a0
    80001afc:	00813403          	ld	s0,8(sp)
    80001b00:	01010113          	addi	sp,sp,16
    80001b04:	00008067          	ret

0000000080001b08 <_ZN6BufferIcLm100EEnwEm>:
void* Buffer<T, numOfElements>::operator new(size_t size)
    80001b08:	ff010113          	addi	sp,sp,-16
    80001b0c:	00113423          	sd	ra,8(sp)
    80001b10:	00813023          	sd	s0,0(sp)
    80001b14:	01010413          	addi	s0,sp,16
    size_t numOfBlocks = size / MEM_BLOCK_SIZE;
    80001b18:	00655793          	srli	a5,a0,0x6
    numOfBlocks += size % MEM_BLOCK_SIZE ? 1 : 0;
    80001b1c:	03f57513          	andi	a0,a0,63
    80001b20:	00050463          	beqz	a0,80001b28 <_ZN6BufferIcLm100EEnwEm+0x20>
    80001b24:	00100513          	li	a0,1
    return MemoryAllocator::allocateMemory(numOfBlocks);
    80001b28:	00f50533          	add	a0,a0,a5
    80001b2c:	00000097          	auipc	ra,0x0
    80001b30:	5d8080e7          	jalr	1496(ra) # 80002104 <_ZN15MemoryAllocator14allocateMemoryEm>
}
    80001b34:	00813083          	ld	ra,8(sp)
    80001b38:	00013403          	ld	s0,0(sp)
    80001b3c:	01010113          	addi	sp,sp,16
    80001b40:	00008067          	ret

0000000080001b44 <_ZN6BufferIcLm100EEC1Ev>:
Buffer<T, numOfElements>::Buffer()
    80001b44:	ff010113          	addi	sp,sp,-16
    80001b48:	00813423          	sd	s0,8(sp)
    80001b4c:	01010413          	addi	s0,sp,16
    80001b50:	32053023          	sd	zero,800(a0)
    80001b54:	32053423          	sd	zero,808(a0)
    80001b58:	32053823          	sd	zero,816(a0)
    for(size_t i = 0; i < numOfElements; i++)
    80001b5c:	00000793          	li	a5,0
    80001b60:	06300713          	li	a4,99
    80001b64:	00f76c63          	bltu	a4,a5,80001b7c <_ZN6BufferIcLm100EEC1Ev+0x38>
        array[i] = nullptr;
    80001b68:	00379713          	slli	a4,a5,0x3
    80001b6c:	00e50733          	add	a4,a0,a4
    80001b70:	00073023          	sd	zero,0(a4)
    for(size_t i = 0; i < numOfElements; i++)
    80001b74:	00178793          	addi	a5,a5,1
    80001b78:	fe9ff06f          	j	80001b60 <_ZN6BufferIcLm100EEC1Ev+0x1c>
}
    80001b7c:	00813403          	ld	s0,8(sp)
    80001b80:	01010113          	addi	sp,sp,16
    80001b84:	00008067          	ret

0000000080001b88 <_ZN5QueueI3TCBEnwEm>:
            tail = prev;
        }
    }
}
template<typename T>
void* Queue<T>::operator new(size_t size)
    80001b88:	ff010113          	addi	sp,sp,-16
    80001b8c:	00113423          	sd	ra,8(sp)
    80001b90:	00813023          	sd	s0,0(sp)
    80001b94:	01010413          	addi	s0,sp,16
{
    size_t numOfBlocks = size / MEM_BLOCK_SIZE;
    80001b98:	00655793          	srli	a5,a0,0x6
    numOfBlocks += size % MEM_BLOCK_SIZE ? 1 : 0;
    80001b9c:	03f57513          	andi	a0,a0,63
    80001ba0:	00050463          	beqz	a0,80001ba8 <_ZN5QueueI3TCBEnwEm+0x20>
    80001ba4:	00100513          	li	a0,1
    return MemoryAllocator::allocateMemory(numOfBlocks);
    80001ba8:	00f50533          	add	a0,a0,a5
    80001bac:	00000097          	auipc	ra,0x0
    80001bb0:	558080e7          	jalr	1368(ra) # 80002104 <_ZN15MemoryAllocator14allocateMemoryEm>
}
    80001bb4:	00813083          	ld	ra,8(sp)
    80001bb8:	00013403          	ld	s0,0(sp)
    80001bbc:	01010113          	addi	sp,sp,16
    80001bc0:	00008067          	ret

0000000080001bc4 <_ZN5QueueI3TCBE6appendEPS0_>:
void Queue<T>::append(T *newElement)
    80001bc4:	ff010113          	addi	sp,sp,-16
    80001bc8:	00813423          	sd	s0,8(sp)
    80001bcc:	01010413          	addi	s0,sp,16
    if(!head)
    80001bd0:	00053783          	ld	a5,0(a0)
    80001bd4:	00078e63          	beqz	a5,80001bf0 <_ZN5QueueI3TCBE6appendEPS0_+0x2c>
        tail->addThreadToState(newElement);
    80001bd8:	00853783          	ld	a5,8(a0)
    void addThreadToState(TCB* newThread) { state = newThread; }
    80001bdc:	04b7b423          	sd	a1,72(a5)
    tail = newElement;
    80001be0:	00b53423          	sd	a1,8(a0)
}
    80001be4:	00813403          	ld	s0,8(sp)
    80001be8:	01010113          	addi	sp,sp,16
    80001bec:	00008067          	ret
        head = newElement;
    80001bf0:	00b53023          	sd	a1,0(a0)
    80001bf4:	fedff06f          	j	80001be0 <_ZN5QueueI3TCBE6appendEPS0_+0x1c>

0000000080001bf8 <_ZN5QueueI3TCBE4takeEv>:
T* Queue<T>::take()
    80001bf8:	ff010113          	addi	sp,sp,-16
    80001bfc:	00813423          	sd	s0,8(sp)
    80001c00:	01010413          	addi	s0,sp,16
    80001c04:	00050793          	mv	a5,a0
    if(!head)
    80001c08:	00053503          	ld	a0,0(a0)
    80001c0c:	00050863          	beqz	a0,80001c1c <_ZN5QueueI3TCBE4takeEv+0x24>
    TCB* getState() const { return state; }
    80001c10:	04853703          	ld	a4,72(a0)
    head = head->getState();
    80001c14:	00e7b023          	sd	a4,0(a5)
    if(!head)
    80001c18:	00070863          	beqz	a4,80001c28 <_ZN5QueueI3TCBE4takeEv+0x30>
}
    80001c1c:	00813403          	ld	s0,8(sp)
    80001c20:	01010113          	addi	sp,sp,16
    80001c24:	00008067          	ret
        tail = nullptr;
    80001c28:	0007b423          	sd	zero,8(a5)
    80001c2c:	ff1ff06f          	j	80001c1c <_ZN5QueueI3TCBE4takeEv+0x24>

0000000080001c30 <_ZN6BufferIcLm100EE4takeEv>:
T* Buffer<T, numOfElements>::take()
    80001c30:	ff010113          	addi	sp,sp,-16
    80001c34:	00813423          	sd	s0,8(sp)
    80001c38:	01010413          	addi	s0,sp,16
    if(count == 0)
    80001c3c:	33053703          	ld	a4,816(a0)
    80001c40:	02070e63          	beqz	a4,80001c7c <_ZN6BufferIcLm100EE4takeEv+0x4c>
    80001c44:	00050793          	mv	a5,a0
    count--;
    80001c48:	fff70713          	addi	a4,a4,-1
    80001c4c:	32e53823          	sd	a4,816(a0)
    T* tempElem = array[head];
    80001c50:	32053703          	ld	a4,800(a0)
    80001c54:	00371693          	slli	a3,a4,0x3
    80001c58:	00d506b3          	add	a3,a0,a3
    80001c5c:	0006b503          	ld	a0,0(a3)
    head = (head + 1) % numOfElements;
    80001c60:	00170713          	addi	a4,a4,1
    80001c64:	06400693          	li	a3,100
    80001c68:	02d77733          	remu	a4,a4,a3
    80001c6c:	32e7b023          	sd	a4,800(a5)
}
    80001c70:	00813403          	ld	s0,8(sp)
    80001c74:	01010113          	addi	sp,sp,16
    80001c78:	00008067          	ret
        return nullptr;
    80001c7c:	00000513          	li	a0,0
    80001c80:	ff1ff06f          	j	80001c70 <_ZN6BufferIcLm100EE4takeEv+0x40>

0000000080001c84 <_ZN6BufferIcLm100EE6appendEPc>:
int Buffer<T, numOfElements>::append(T *element)
    80001c84:	ff010113          	addi	sp,sp,-16
    80001c88:	00813423          	sd	s0,8(sp)
    80001c8c:	01010413          	addi	s0,sp,16
    if(count == numOfElements)
    80001c90:	33053783          	ld	a5,816(a0)
    80001c94:	06400713          	li	a4,100
    80001c98:	02e78e63          	beq	a5,a4,80001cd4 <_ZN6BufferIcLm100EE6appendEPc+0x50>
    count++;
    80001c9c:	00178793          	addi	a5,a5,1
    80001ca0:	32f53823          	sd	a5,816(a0)
    array[tail] = element;
    80001ca4:	32853783          	ld	a5,808(a0)
    80001ca8:	00379713          	slli	a4,a5,0x3
    80001cac:	00e50733          	add	a4,a0,a4
    80001cb0:	00b73023          	sd	a1,0(a4)
    tail = (tail + 1) % numOfElements;
    80001cb4:	00178793          	addi	a5,a5,1
    80001cb8:	06400713          	li	a4,100
    80001cbc:	02e7f7b3          	remu	a5,a5,a4
    80001cc0:	32f53423          	sd	a5,808(a0)
    return 0;
    80001cc4:	00000513          	li	a0,0
}
    80001cc8:	00813403          	ld	s0,8(sp)
    80001ccc:	01010113          	addi	sp,sp,16
    80001cd0:	00008067          	ret
        return -1;
    80001cd4:	fff00513          	li	a0,-1
    80001cd8:	ff1ff06f          	j	80001cc8 <_ZN6BufferIcLm100EE6appendEPc+0x44>

0000000080001cdc <_Z41__static_initialization_and_destruction_0ii>:
    TCB* newThread = queueReadyThreads->take();
    //headReadyThread = headReadyThread->getState();

    newThread->addThreadToState(nullptr);
    return newThread;
    80001cdc:	00100793          	li	a5,1
    80001ce0:	00f50463          	beq	a0,a5,80001ce8 <_Z41__static_initialization_and_destruction_0ii+0xc>
    80001ce4:	00008067          	ret
    80001ce8:	000107b7          	lui	a5,0x10
    80001cec:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80001cf0:	fef59ae3          	bne	a1,a5,80001ce4 <_Z41__static_initialization_and_destruction_0ii+0x8>
    80001cf4:	ff010113          	addi	sp,sp,-16
    80001cf8:	00113423          	sd	ra,8(sp)
    80001cfc:	00813023          	sd	s0,0(sp)
    80001d00:	01010413          	addi	s0,sp,16
Queue<TCB>* Scheduler::queueReadyThreads = new Queue<TCB>();
    80001d04:	01000513          	li	a0,16
    80001d08:	00000097          	auipc	ra,0x0
    80001d0c:	e80080e7          	jalr	-384(ra) # 80001b88 <_ZN5QueueI3TCBEnwEm>
    80001d10:	00053023          	sd	zero,0(a0)
    80001d14:	00053423          	sd	zero,8(a0)
    80001d18:	00005797          	auipc	a5,0x5
    80001d1c:	68a7b423          	sd	a0,1672(a5) # 800073a0 <_ZN9Scheduler17queueReadyThreadsE>
    80001d20:	00813083          	ld	ra,8(sp)
    80001d24:	00013403          	ld	s0,0(sp)
    80001d28:	01010113          	addi	sp,sp,16
    80001d2c:	00008067          	ret

0000000080001d30 <_ZN9Scheduler3putEP3TCB>:
{
    80001d30:	ff010113          	addi	sp,sp,-16
    80001d34:	00113423          	sd	ra,8(sp)
    80001d38:	00813023          	sd	s0,0(sp)
    80001d3c:	01010413          	addi	s0,sp,16
    80001d40:	00050593          	mv	a1,a0
    queueReadyThreads->append(readyThread);
    80001d44:	00005517          	auipc	a0,0x5
    80001d48:	65c53503          	ld	a0,1628(a0) # 800073a0 <_ZN9Scheduler17queueReadyThreadsE>
    80001d4c:	00000097          	auipc	ra,0x0
    80001d50:	e78080e7          	jalr	-392(ra) # 80001bc4 <_ZN5QueueI3TCBE6appendEPS0_>
}
    80001d54:	00813083          	ld	ra,8(sp)
    80001d58:	00013403          	ld	s0,0(sp)
    80001d5c:	01010113          	addi	sp,sp,16
    80001d60:	00008067          	ret

0000000080001d64 <_ZN9Scheduler3getEv>:
    if(queueReadyThreads->isQueueEmpty())
    80001d64:	00005517          	auipc	a0,0x5
    80001d68:	63c53503          	ld	a0,1596(a0) # 800073a0 <_ZN9Scheduler17queueReadyThreadsE>
    bool isQueueEmpty() const { return !head; }
    80001d6c:	00053783          	ld	a5,0(a0)
    80001d70:	02078863          	beqz	a5,80001da0 <_ZN9Scheduler3getEv+0x3c>
{
    80001d74:	ff010113          	addi	sp,sp,-16
    80001d78:	00113423          	sd	ra,8(sp)
    80001d7c:	00813023          	sd	s0,0(sp)
    80001d80:	01010413          	addi	s0,sp,16
    TCB* newThread = queueReadyThreads->take();
    80001d84:	00000097          	auipc	ra,0x0
    80001d88:	e74080e7          	jalr	-396(ra) # 80001bf8 <_ZN5QueueI3TCBE4takeEv>
    void addThreadToState(TCB* newThread) { state = newThread; }
    80001d8c:	04053423          	sd	zero,72(a0)
    80001d90:	00813083          	ld	ra,8(sp)
    80001d94:	00013403          	ld	s0,0(sp)
    80001d98:	01010113          	addi	sp,sp,16
    80001d9c:	00008067          	ret
        return idleThread;
    80001da0:	00005517          	auipc	a0,0x5
    80001da4:	60853503          	ld	a0,1544(a0) # 800073a8 <_ZN9Scheduler10idleThreadE>
    80001da8:	00008067          	ret

0000000080001dac <_GLOBAL__sub_I__ZN9Scheduler17queueReadyThreadsE>:
    80001dac:	ff010113          	addi	sp,sp,-16
    80001db0:	00113423          	sd	ra,8(sp)
    80001db4:	00813023          	sd	s0,0(sp)
    80001db8:	01010413          	addi	s0,sp,16
    80001dbc:	000105b7          	lui	a1,0x10
    80001dc0:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    80001dc4:	00100513          	li	a0,1
    80001dc8:	00000097          	auipc	ra,0x0
    80001dcc:	f14080e7          	jalr	-236(ra) # 80001cdc <_Z41__static_initialization_and_destruction_0ii>
    80001dd0:	00813083          	ld	ra,8(sp)
    80001dd4:	00013403          	ld	s0,0(sp)
    80001dd8:	01010113          	addi	sp,sp,16
    80001ddc:	00008067          	ret

0000000080001de0 <main>:
// Created by os on 11/29/25.
//
#include "../h/MemoryAllocator.hpp"
#include "../h/Kernel.hpp"
#include "../h/syscall_c.hpp"
void main(){
    80001de0:	ff010113          	addi	sp,sp,-16
    80001de4:	00813423          	sd	s0,8(sp)
    80001de8:	01010413          	addi	s0,sp,16
////    __asm__ volatile ("ecall");
//    void* allocMem1 = mem_alloc(100);
//    mem_free(allocMem1);
//    void* allocMem2 = mem_alloc(10);
//    mem_free(allocMem2);
    80001dec:	00813403          	ld	s0,8(sp)
    80001df0:	01010113          	addi	sp,sp,16
    80001df4:	00008067          	ret

0000000080001df8 <_ZN3TCB13threadWrapperEv>:
    {
        Scheduler::put(this);
    }
}
void TCB::threadWrapper()
{
    80001df8:	ff010113          	addi	sp,sp,-16
    80001dfc:	00113423          	sd	ra,8(sp)
    80001e00:	00813023          	sd	s0,0(sp)
    80001e04:	01010413          	addi	s0,sp,16
    running->body(running->arguments);
    80001e08:	00005797          	auipc	a5,0x5
    80001e0c:	5a87b783          	ld	a5,1448(a5) # 800073b0 <_ZN3TCB7runningE>
    80001e10:	0007b703          	ld	a4,0(a5)
    80001e14:	0387b503          	ld	a0,56(a5)
    80001e18:	000700e7          	jalr	a4
    thread_exit();
    80001e1c:	fffff097          	auipc	ra,0xfffff
    80001e20:	61c080e7          	jalr	1564(ra) # 80001438 <_Z11thread_exitv>

}
    80001e24:	00813083          	ld	ra,8(sp)
    80001e28:	00013403          	ld	s0,0(sp)
    80001e2c:	01010113          	addi	sp,sp,16
    80001e30:	00008067          	ret

0000000080001e34 <_ZN3TCB16initializeThreadEPFvPvES0_S0_S0_P10ObjectPoolIS_Lm20EEN12KernelConfig4ModeENS6_11ThreadStateE>:
    body = function;
    80001e34:	00b53023          	sd	a1,0(a0)
    timeSlice = DEFAULT_TIME_SLICE;
    80001e38:	00200593          	li	a1,2
    80001e3c:	02b53823          	sd	a1,48(a0)
    state = nullptr;
    80001e40:	04053423          	sd	zero,72(a0)
    finished = false;
    80001e44:	04050823          	sb	zero,80(a0)
    arguments = arg;
    80001e48:	02c53c23          	sd	a2,56(a0)
    waitOnSemaphore = nullptr;
    80001e4c:	04053023          	sd	zero,64(a0)
    timeToSleep = 0;
    80001e50:	04053c23          	sd	zero,88(a0)
    sourcePool = pool;
    80001e54:	06f53023          	sd	a5,96(a0)
    userStack = (void*)((uint8*)allocatedStack - DEFAULT_STACK_SIZE);
    80001e58:	fffff7b7          	lui	a5,0xfffff
    80001e5c:	00f687b3          	add	a5,a3,a5
    80001e60:	02f53023          	sd	a5,32(a0)
    systemStack = (void*)((uint8*)allocatedSystemStack - KernelConfig::DEFAULT_SYSTEM_STACK_SIZE);
    80001e64:	c0070793          	addi	a5,a4,-1024
    80001e68:	02f53423          	sd	a5,40(a0)
    *((uint64*)allocatedSystemStack - 30) = (uint64)((uint64*)allocatedStack - 2);
    80001e6c:	ff068693          	addi	a3,a3,-16
    80001e70:	f0d73823          	sd	a3,-240(a4)
    __asm__ volatile ("csrc sip, %[reg]":: [reg] "r"(mask));
}
inline uint64 Machine::readSscratch()
{
    uint64 returnValue;
    __asm__ volatile ("csrr %[reg], sscratch": [reg] "=r"(returnValue));
    80001e74:	140027f3          	csrr	a5,sscratch
    context = {Machine::readSscratch(), (uint64) ((uint64*)allocatedSystemStack - 32), mode};
    80001e78:	f0070713          	addi	a4,a4,-256
    80001e7c:	00f53423          	sd	a5,8(a0)
    80001e80:	00e53823          	sd	a4,16(a0)
    80001e84:	01052c23          	sw	a6,24(a0)
    Machine::writeSepc((uint64)&threadWrapper);
    80001e88:	00000797          	auipc	a5,0x0
    80001e8c:	f7078793          	addi	a5,a5,-144 # 80001df8 <_ZN3TCB13threadWrapperEv>
    return returnValue;
}
inline void Machine::writeSepc(uint64 address)
{
    __asm__ volatile("csrw sepc, %[reg]":: [reg] "r"(address));
    80001e90:	14179073          	csrw	sepc,a5
    if(stateOfThread == KernelConfig::ACTIVE)
    80001e94:	00088463          	beqz	a7,80001e9c <_ZN3TCB16initializeThreadEPFvPvES0_S0_S0_P10ObjectPoolIS_Lm20EEN12KernelConfig4ModeENS6_11ThreadStateE+0x68>
    80001e98:	00008067          	ret
{
    80001e9c:	ff010113          	addi	sp,sp,-16
    80001ea0:	00113423          	sd	ra,8(sp)
    80001ea4:	00813023          	sd	s0,0(sp)
    80001ea8:	01010413          	addi	s0,sp,16
        Scheduler::put(this);
    80001eac:	00000097          	auipc	ra,0x0
    80001eb0:	e84080e7          	jalr	-380(ra) # 80001d30 <_ZN9Scheduler3putEP3TCB>
}
    80001eb4:	00813083          	ld	ra,8(sp)
    80001eb8:	00013403          	ld	s0,0(sp)
    80001ebc:	01010113          	addi	sp,sp,16
    80001ec0:	00008067          	ret

0000000080001ec4 <_ZN3TCB5yieldEPS_S0_>:
void TCB::yield(TCB *oldThread, TCB *newThread)
{
    80001ec4:	ff010113          	addi	sp,sp,-16
    80001ec8:	00113423          	sd	ra,8(sp)
    80001ecc:	00813023          	sd	s0,0(sp)
    80001ed0:	01010413          	addi	s0,sp,16
    context_switch(oldThread->getContext(), newThread->getContext());
    80001ed4:	00858593          	addi	a1,a1,8
    80001ed8:	00850513          	addi	a0,a0,8
    80001edc:	fffff097          	auipc	ra,0xfffff
    80001ee0:	2c4080e7          	jalr	708(ra) # 800011a0 <context_switch>
}
    80001ee4:	00813083          	ld	ra,8(sp)
    80001ee8:	00013403          	ld	s0,0(sp)
    80001eec:	01010113          	addi	sp,sp,16
    80001ef0:	00008067          	ret

0000000080001ef4 <_ZN3TCB8dispatchEv>:

void TCB::dispatch()
{
    80001ef4:	fe010113          	addi	sp,sp,-32
    80001ef8:	00113c23          	sd	ra,24(sp)
    80001efc:	00813823          	sd	s0,16(sp)
    80001f00:	00913423          	sd	s1,8(sp)
    80001f04:	02010413          	addi	s0,sp,32
    TCB* oldThread = running;
    80001f08:	00005497          	auipc	s1,0x5
    80001f0c:	4a84b483          	ld	s1,1192(s1) # 800073b0 <_ZN3TCB7runningE>
    bool isFinished() const { return finished; }
    80001f10:	0504c783          	lbu	a5,80(s1)
    if(!oldThread->isFinished())
    80001f14:	02078c63          	beqz	a5,80001f4c <_ZN3TCB8dispatchEv+0x58>
    {
        Scheduler::put(oldThread);
    }
    running = Scheduler::get();
    80001f18:	00000097          	auipc	ra,0x0
    80001f1c:	e4c080e7          	jalr	-436(ra) # 80001d64 <_ZN9Scheduler3getEv>
    80001f20:	00050593          	mv	a1,a0
    80001f24:	00005797          	auipc	a5,0x5
    80001f28:	48a7b623          	sd	a0,1164(a5) # 800073b0 <_ZN3TCB7runningE>
    yield(oldThread, running);
    80001f2c:	00048513          	mv	a0,s1
    80001f30:	00000097          	auipc	ra,0x0
    80001f34:	f94080e7          	jalr	-108(ra) # 80001ec4 <_ZN3TCB5yieldEPS_S0_>
    80001f38:	01813083          	ld	ra,24(sp)
    80001f3c:	01013403          	ld	s0,16(sp)
    80001f40:	00813483          	ld	s1,8(sp)
    80001f44:	02010113          	addi	sp,sp,32
    80001f48:	00008067          	ret
        Scheduler::put(oldThread);
    80001f4c:	00048513          	mv	a0,s1
    80001f50:	00000097          	auipc	ra,0x0
    80001f54:	de0080e7          	jalr	-544(ra) # 80001d30 <_ZN9Scheduler3putEP3TCB>
    80001f58:	fc1ff06f          	j	80001f18 <_ZN3TCB8dispatchEv+0x24>

0000000080001f5c <_ZN15MemoryAllocator16initializeMemoryEv>:
size_t MemoryAllocator::NUM_OF_BLOCKS = 0;
size_t MemoryAllocator::numOfFreeBlocks = 0;
MemoryAllocator::FreeBlock* MemoryAllocator::firstFreeBlock = nullptr;

void MemoryAllocator::initializeMemory()
{
    80001f5c:	ff010113          	addi	sp,sp,-16
    80001f60:	00813423          	sd	s0,8(sp)
    80001f64:	01010413          	addi	s0,sp,16

    NUM_OF_BLOCKS = ((uint8*)HEAP_END_ADDR - (uint8*)HEAP_START_ADDR) / MEM_BLOCK_SIZE;
    80001f68:	00005797          	auipc	a5,0x5
    80001f6c:	3987b783          	ld	a5,920(a5) # 80007300 <_GLOBAL_OFFSET_TABLE_+0x70>
    80001f70:	0007b703          	ld	a4,0(a5)
    80001f74:	00005797          	auipc	a5,0x5
    80001f78:	3347b783          	ld	a5,820(a5) # 800072a8 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001f7c:	0007b683          	ld	a3,0(a5)
    80001f80:	40d70733          	sub	a4,a4,a3
    80001f84:	00675713          	srli	a4,a4,0x6
    80001f88:	00005797          	auipc	a5,0x5
    80001f8c:	43878793          	addi	a5,a5,1080 # 800073c0 <_ZN15MemoryAllocator13NUM_OF_BLOCKSE>
    80001f90:	00e7b023          	sd	a4,0(a5)
    numOfFreeBlocks = NUM_OF_BLOCKS;
    80001f94:	00e7b423          	sd	a4,8(a5)

    firstFreeBlock = (FreeBlock*)(HEAP_START_ADDR);
    80001f98:	00d7b823          	sd	a3,16(a5)

    firstFreeBlock->flagFree = true;
    80001f9c:	00100613          	li	a2,1
    80001fa0:	00c68023          	sb	a2,0(a3)
    firstFreeBlock->numOfBlocks = NUM_OF_BLOCKS;
    80001fa4:	0107b703          	ld	a4,16(a5)
    80001fa8:	0007b683          	ld	a3,0(a5)
    80001fac:	00d73423          	sd	a3,8(a4)
    firstFreeBlock->nextBlock = nullptr;
    80001fb0:	00073823          	sd	zero,16(a4)
    firstFreeBlock->previousBlock = nullptr;
    80001fb4:	00073c23          	sd	zero,24(a4)
    flagSystemInitialize = 1;
    80001fb8:	00c78c23          	sb	a2,24(a5)
}
    80001fbc:	00813403          	ld	s0,8(sp)
    80001fc0:	01010113          	addi	sp,sp,16
    80001fc4:	00008067          	ret

0000000080001fc8 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m>:
    occupiedBlock++;
    return occupiedBlock;
}

void MemoryAllocator::remapMemory(FreeBlock **head, FreeBlock *allocatedBlocks, size_t blocksToAllocate)
{
    80001fc8:	ff010113          	addi	sp,sp,-16
    80001fcc:	00813423          	sd	s0,8(sp)
    80001fd0:	01010413          	addi	s0,sp,16

    if(allocatedBlocks->numOfBlocks == 0)
    80001fd4:	0085b783          	ld	a5,8(a1)
    80001fd8:	04079263          	bnez	a5,8000201c <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x54>
    {

        if(allocatedBlocks->previousBlock)
    80001fdc:	0185b783          	ld	a5,24(a1)
    80001fe0:	00078663          	beqz	a5,80001fec <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x24>
        {
            allocatedBlocks->previousBlock->nextBlock = allocatedBlocks->nextBlock;
    80001fe4:	0105b703          	ld	a4,16(a1)
    80001fe8:	00e7b823          	sd	a4,16(a5)
        }

        if(allocatedBlocks->nextBlock)
    80001fec:	0105b783          	ld	a5,16(a1)
    80001ff0:	00078663          	beqz	a5,80001ffc <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x34>
        {
            allocatedBlocks->nextBlock->previousBlock = allocatedBlocks->previousBlock;
    80001ff4:	0185b703          	ld	a4,24(a1)
    80001ff8:	00e7bc23          	sd	a4,24(a5)
        }

        if(*head == allocatedBlocks)
    80001ffc:	00053783          	ld	a5,0(a0)
    80002000:	00b78863          	beq	a5,a1,80002010 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x48>
        {
            *head = newFreeBlock;
        }
    }

}
    80002004:	00813403          	ld	s0,8(sp)
    80002008:	01010113          	addi	sp,sp,16
    8000200c:	00008067          	ret
            *head = allocatedBlocks->nextBlock;
    80002010:	0105b783          	ld	a5,16(a1)
    80002014:	00f53023          	sd	a5,0(a0)
    80002018:	fedff06f          	j	80002004 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x3c>
        FreeBlock* newFreeBlock = (FreeBlock*)((uint8*)allocatedBlocks + blocksToAllocate * MEM_BLOCK_SIZE);
    8000201c:	00661613          	slli	a2,a2,0x6
    80002020:	00c58633          	add	a2,a1,a2
        newFreeBlock->flagFree = true;
    80002024:	00100793          	li	a5,1
    80002028:	00f60023          	sb	a5,0(a2)
        newFreeBlock->numOfBlocks = allocatedBlocks->numOfBlocks;
    8000202c:	0085b783          	ld	a5,8(a1)
    80002030:	00f63423          	sd	a5,8(a2)
        if(allocatedBlocks->previousBlock)
    80002034:	0185b783          	ld	a5,24(a1)
    80002038:	00078463          	beqz	a5,80002040 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x78>
            allocatedBlocks->previousBlock->nextBlock = newFreeBlock;
    8000203c:	00c7b823          	sd	a2,16(a5)
        newFreeBlock->previousBlock = allocatedBlocks->previousBlock;
    80002040:	0185b783          	ld	a5,24(a1)
    80002044:	00f63c23          	sd	a5,24(a2)
        newFreeBlock->nextBlock = allocatedBlocks->nextBlock;
    80002048:	0105b783          	ld	a5,16(a1)
    8000204c:	00f63823          	sd	a5,16(a2)
        if(*head == allocatedBlocks)
    80002050:	00053783          	ld	a5,0(a0)
    80002054:	fab798e3          	bne	a5,a1,80002004 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x3c>
            *head = newFreeBlock;
    80002058:	00c53023          	sd	a2,0(a0)
}
    8000205c:	fa9ff06f          	j	80002004 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x3c>

0000000080002060 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm>:
{
    80002060:	fe010113          	addi	sp,sp,-32
    80002064:	00113c23          	sd	ra,24(sp)
    80002068:	00813823          	sd	s0,16(sp)
    8000206c:	00913423          	sd	s1,8(sp)
    80002070:	01213023          	sd	s2,0(sp)
    80002074:	02010413          	addi	s0,sp,32
    80002078:	00058913          	mv	s2,a1
    for(FreeBlock* curr = (*head); curr; curr = curr->nextBlock)
    8000207c:	00053783          	ld	a5,0(a0)
    FreeBlock* bestBlock = nullptr;
    80002080:	00000493          	li	s1,0
    80002084:	00c0006f          	j	80002090 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x30>
                bestBlock = curr;
    80002088:	00078493          	mv	s1,a5
    for(FreeBlock* curr = (*head); curr; curr = curr->nextBlock)
    8000208c:	0107b783          	ld	a5,16(a5)
    80002090:	02078063          	beqz	a5,800020b0 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x50>
        if(curr->numOfBlocks >= blocksToAllocate)
    80002094:	0087b703          	ld	a4,8(a5)
    80002098:	ff276ae3          	bltu	a4,s2,8000208c <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x2c>
        {   if(bestBlock == nullptr)
    8000209c:	fe0486e3          	beqz	s1,80002088 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x28>
            if(bestBlock->numOfBlocks > curr->numOfBlocks)
    800020a0:	0084b683          	ld	a3,8(s1)
    800020a4:	fed774e3          	bgeu	a4,a3,8000208c <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x2c>
                bestBlock = curr;
    800020a8:	00078493          	mv	s1,a5
    800020ac:	fe1ff06f          	j	8000208c <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x2c>
    numOfFreeBlocks -= blocksToAllocate;
    800020b0:	00005717          	auipc	a4,0x5
    800020b4:	31070713          	addi	a4,a4,784 # 800073c0 <_ZN15MemoryAllocator13NUM_OF_BLOCKSE>
    800020b8:	00873783          	ld	a5,8(a4)
    800020bc:	412787b3          	sub	a5,a5,s2
    800020c0:	00f73423          	sd	a5,8(a4)
    bestBlock->numOfBlocks -= blocksToAllocate;
    800020c4:	0084b783          	ld	a5,8(s1)
    800020c8:	412787b3          	sub	a5,a5,s2
    800020cc:	00f4b423          	sd	a5,8(s1)
    remapMemory(head, bestBlock, blocksToAllocate);
    800020d0:	00090613          	mv	a2,s2
    800020d4:	00048593          	mv	a1,s1
    800020d8:	00000097          	auipc	ra,0x0
    800020dc:	ef0080e7          	jalr	-272(ra) # 80001fc8 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m>
    occupiedBlock->flagFree = false;
    800020e0:	00048023          	sb	zero,0(s1)
    occupiedBlock->numOfBlocks = blocksToAllocate;
    800020e4:	0124b423          	sd	s2,8(s1)
}
    800020e8:	01048513          	addi	a0,s1,16
    800020ec:	01813083          	ld	ra,24(sp)
    800020f0:	01013403          	ld	s0,16(sp)
    800020f4:	00813483          	ld	s1,8(sp)
    800020f8:	00013903          	ld	s2,0(sp)
    800020fc:	02010113          	addi	sp,sp,32
    80002100:	00008067          	ret

0000000080002104 <_ZN15MemoryAllocator14allocateMemoryEm>:
{
    80002104:	fe010113          	addi	sp,sp,-32
    80002108:	00113c23          	sd	ra,24(sp)
    8000210c:	00813823          	sd	s0,16(sp)
    80002110:	00913423          	sd	s1,8(sp)
    80002114:	02010413          	addi	s0,sp,32
    80002118:	00050493          	mv	s1,a0
    if(!flagSystemInitialize)
    8000211c:	00005797          	auipc	a5,0x5
    80002120:	2bc7c783          	lbu	a5,700(a5) # 800073d8 <_ZN15MemoryAllocator20flagSystemInitializeE>
    80002124:	02078c63          	beqz	a5,8000215c <_ZN15MemoryAllocator14allocateMemoryEm+0x58>
    if(numOfFreeBlocks < blocksToAllocate)
    80002128:	00005797          	auipc	a5,0x5
    8000212c:	2a07b783          	ld	a5,672(a5) # 800073c8 <_ZN15MemoryAllocator15numOfFreeBlocksE>
    80002130:	0297ec63          	bltu	a5,s1,80002168 <_ZN15MemoryAllocator14allocateMemoryEm+0x64>
    return findBestFit(&firstFreeBlock, blocksToAllocate);
    80002134:	00048593          	mv	a1,s1
    80002138:	00005517          	auipc	a0,0x5
    8000213c:	29850513          	addi	a0,a0,664 # 800073d0 <_ZN15MemoryAllocator14firstFreeBlockE>
    80002140:	00000097          	auipc	ra,0x0
    80002144:	f20080e7          	jalr	-224(ra) # 80002060 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm>
}
    80002148:	01813083          	ld	ra,24(sp)
    8000214c:	01013403          	ld	s0,16(sp)
    80002150:	00813483          	ld	s1,8(sp)
    80002154:	02010113          	addi	sp,sp,32
    80002158:	00008067          	ret
        initializeMemory();
    8000215c:	00000097          	auipc	ra,0x0
    80002160:	e00080e7          	jalr	-512(ra) # 80001f5c <_ZN15MemoryAllocator16initializeMemoryEv>
    80002164:	fc5ff06f          	j	80002128 <_ZN15MemoryAllocator14allocateMemoryEm+0x24>
        return nullptr;
    80002168:	00000513          	li	a0,0
    8000216c:	fddff06f          	j	80002148 <_ZN15MemoryAllocator14allocateMemoryEm+0x44>

0000000080002170 <_ZN15MemoryAllocator17findNextFreeBlockEPNS_9FreeBlockE>:
MemoryAllocator::FreeBlock* MemoryAllocator::findNextFreeBlock(FreeBlock* memoryToFree)
{
    80002170:	ff010113          	addi	sp,sp,-16
    80002174:	00813423          	sd	s0,8(sp)
    80002178:	01010413          	addi	s0,sp,16
    for(uint8* i = (uint8*)memoryToFree; i + MEM_BLOCK_SIZE <= (uint8*)HEAP_END_ADDR; i+= (((OccupiedBlock*)i)->numOfBlocks * MEM_BLOCK_SIZE))
    8000217c:	04050793          	addi	a5,a0,64
    80002180:	00005717          	auipc	a4,0x5
    80002184:	18073703          	ld	a4,384(a4) # 80007300 <_GLOBAL_OFFSET_TABLE_+0x70>
    80002188:	00073703          	ld	a4,0(a4)
    8000218c:	00f76e63          	bltu	a4,a5,800021a8 <_ZN15MemoryAllocator17findNextFreeBlockEPNS_9FreeBlockE+0x38>
    {
        if(((FreeBlock*)i)->flagFree)
    80002190:	00054783          	lbu	a5,0(a0)
    80002194:	00079c63          	bnez	a5,800021ac <_ZN15MemoryAllocator17findNextFreeBlockEPNS_9FreeBlockE+0x3c>
    for(uint8* i = (uint8*)memoryToFree; i + MEM_BLOCK_SIZE <= (uint8*)HEAP_END_ADDR; i+= (((OccupiedBlock*)i)->numOfBlocks * MEM_BLOCK_SIZE))
    80002198:	00853783          	ld	a5,8(a0)
    8000219c:	00679793          	slli	a5,a5,0x6
    800021a0:	00f50533          	add	a0,a0,a5
    800021a4:	fd9ff06f          	j	8000217c <_ZN15MemoryAllocator17findNextFreeBlockEPNS_9FreeBlockE+0xc>
        {
            return (FreeBlock*)i;
        }
    }
    return nullptr;
    800021a8:	00000513          	li	a0,0
}
    800021ac:	00813403          	ld	s0,8(sp)
    800021b0:	01010113          	addi	sp,sp,16
    800021b4:	00008067          	ret

00000000800021b8 <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_>:

MemoryAllocator::FreeBlock* MemoryAllocator::findPreviousFreeBlock(FreeBlock* head, FreeBlock* memoryToFree)
{
    800021b8:	ff010113          	addi	sp,sp,-16
    800021bc:	00813423          	sd	s0,8(sp)
    800021c0:	01010413          	addi	s0,sp,16
    FreeBlock* temp = head;
    for(; temp && temp <= memoryToFree; temp = temp->nextBlock){}
    800021c4:	00050863          	beqz	a0,800021d4 <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_+0x1c>
    800021c8:	00a5e663          	bltu	a1,a0,800021d4 <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_+0x1c>
    800021cc:	01053503          	ld	a0,16(a0)
    800021d0:	ff5ff06f          	j	800021c4 <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_+0xc>
    if(!temp)
    800021d4:	00050463          	beqz	a0,800021dc <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_+0x24>
    {
        return nullptr;
    }
    return temp->previousBlock;
    800021d8:	01853503          	ld	a0,24(a0)
}
    800021dc:	00813403          	ld	s0,8(sp)
    800021e0:	01010113          	addi	sp,sp,16
    800021e4:	00008067          	ret

00000000800021e8 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_>:

    return 0;
}

void MemoryAllocator::connectAdjacentBlocks(FreeBlock* previousBlock, FreeBlock* adjacentBlock)
{
    800021e8:	ff010113          	addi	sp,sp,-16
    800021ec:	00813423          	sd	s0,8(sp)
    800021f0:	01010413          	addi	s0,sp,16


    if(adjacentBlock == (FreeBlock*)((uint8 *)previousBlock + previousBlock->numOfBlocks * MEM_BLOCK_SIZE))
    800021f4:	00853703          	ld	a4,8(a0)
    800021f8:	00671793          	slli	a5,a4,0x6
    800021fc:	00f507b3          	add	a5,a0,a5
    80002200:	00b78e63          	beq	a5,a1,8000221c <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_+0x34>
        adjacentBlock->previousBlock = nullptr;

    }
    else
    {
        previousBlock->nextBlock = adjacentBlock;
    80002204:	00b53823          	sd	a1,16(a0)
        if(adjacentBlock)
    80002208:	00058463          	beqz	a1,80002210 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_+0x28>
        {
            adjacentBlock->previousBlock = previousBlock;
    8000220c:	00a5bc23          	sd	a0,24(a1)
        }

    }
}
    80002210:	00813403          	ld	s0,8(sp)
    80002214:	01010113          	addi	sp,sp,16
    80002218:	00008067          	ret
        previousBlock->numOfBlocks += adjacentBlock->numOfBlocks;
    8000221c:	0085b783          	ld	a5,8(a1)
    80002220:	00f70733          	add	a4,a4,a5
    80002224:	00e53423          	sd	a4,8(a0)
        previousBlock->nextBlock = adjacentBlock->nextBlock;
    80002228:	0105b783          	ld	a5,16(a1)
    8000222c:	00f53823          	sd	a5,16(a0)
        if(adjacentBlock->nextBlock != nullptr)
    80002230:	00078463          	beqz	a5,80002238 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_+0x50>
            adjacentBlock->nextBlock->previousBlock = previousBlock;
    80002234:	00a7bc23          	sd	a0,24(a5)
        if(adjacentBlock->previousBlock != previousBlock && adjacentBlock->previousBlock != nullptr)
    80002238:	0185b783          	ld	a5,24(a1)
    8000223c:	00a78863          	beq	a5,a0,8000224c <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_+0x64>
    80002240:	00078663          	beqz	a5,8000224c <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_+0x64>
            previousBlock->previousBlock = adjacentBlock->previousBlock;
    80002244:	00f53c23          	sd	a5,24(a0)
            adjacentBlock->previousBlock->nextBlock = previousBlock;
    80002248:	00a7b823          	sd	a0,16(a5)
        adjacentBlock->flagFree = false;
    8000224c:	00058023          	sb	zero,0(a1)
        adjacentBlock->numOfBlocks = 0;
    80002250:	0005b423          	sd	zero,8(a1)
        adjacentBlock->nextBlock = nullptr;
    80002254:	0005b823          	sd	zero,16(a1)
        adjacentBlock->previousBlock = nullptr;
    80002258:	0005bc23          	sd	zero,24(a1)
    8000225c:	fb5ff06f          	j	80002210 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_+0x28>

0000000080002260 <_ZN15MemoryAllocator10freeMemoryEPv>:
    if(!addressToFree)
    80002260:	0c050e63          	beqz	a0,8000233c <_ZN15MemoryAllocator10freeMemoryEPv+0xdc>
{
    80002264:	fc010113          	addi	sp,sp,-64
    80002268:	02113c23          	sd	ra,56(sp)
    8000226c:	02813823          	sd	s0,48(sp)
    80002270:	02913423          	sd	s1,40(sp)
    80002274:	03213023          	sd	s2,32(sp)
    80002278:	01313c23          	sd	s3,24(sp)
    8000227c:	01413823          	sd	s4,16(sp)
    80002280:	01513423          	sd	s5,8(sp)
    80002284:	04010413          	addi	s0,sp,64
    80002288:	00050493          	mv	s1,a0
    tempAddress--;
    8000228c:	ff050913          	addi	s2,a0,-16
    int numOfTakenBlocks = tempAddress->numOfBlocks;
    80002290:	ff852a83          	lw	s5,-8(a0)
    numOfFreeBlocks += numOfTakenBlocks;
    80002294:	00005997          	auipc	s3,0x5
    80002298:	12c98993          	addi	s3,s3,300 # 800073c0 <_ZN15MemoryAllocator13NUM_OF_BLOCKSE>
    8000229c:	0089b783          	ld	a5,8(s3)
    800022a0:	015787b3          	add	a5,a5,s5
    800022a4:	00f9b423          	sd	a5,8(s3)
    FreeBlock* nextFreeBlock = findNextFreeBlock(newFreeBlock);
    800022a8:	00090513          	mv	a0,s2
    800022ac:	00000097          	auipc	ra,0x0
    800022b0:	ec4080e7          	jalr	-316(ra) # 80002170 <_ZN15MemoryAllocator17findNextFreeBlockEPNS_9FreeBlockE>
    800022b4:	00050a13          	mv	s4,a0
    FreeBlock* previousFreeBlock = findPreviousFreeBlock(firstFreeBlock, newFreeBlock);
    800022b8:	00090593          	mv	a1,s2
    800022bc:	0109b503          	ld	a0,16(s3)
    800022c0:	00000097          	auipc	ra,0x0
    800022c4:	ef8080e7          	jalr	-264(ra) # 800021b8 <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_>
    800022c8:	00050993          	mv	s3,a0
    newFreeBlock->flagFree = true;
    800022cc:	00100793          	li	a5,1
    800022d0:	fef48823          	sb	a5,-16(s1)
    newFreeBlock->numOfBlocks = numOfTakenBlocks;
    800022d4:	ff54bc23          	sd	s5,-8(s1)
    newFreeBlock->nextBlock = nullptr;
    800022d8:	0004b023          	sd	zero,0(s1)
    newFreeBlock->previousBlock = nullptr;
    800022dc:	0004b423          	sd	zero,8(s1)
    connectAdjacentBlocks(newFreeBlock, nextFreeBlock);
    800022e0:	000a0593          	mv	a1,s4
    800022e4:	00090513          	mv	a0,s2
    800022e8:	00000097          	auipc	ra,0x0
    800022ec:	f00080e7          	jalr	-256(ra) # 800021e8 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_>
    if(previousFreeBlock)
    800022f0:	02098e63          	beqz	s3,8000232c <_ZN15MemoryAllocator10freeMemoryEPv+0xcc>
        connectAdjacentBlocks(previousFreeBlock, newFreeBlock);
    800022f4:	00090593          	mv	a1,s2
    800022f8:	00098513          	mv	a0,s3
    800022fc:	00000097          	auipc	ra,0x0
    80002300:	eec080e7          	jalr	-276(ra) # 800021e8 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_>
    return 0;
    80002304:	00000513          	li	a0,0
}
    80002308:	03813083          	ld	ra,56(sp)
    8000230c:	03013403          	ld	s0,48(sp)
    80002310:	02813483          	ld	s1,40(sp)
    80002314:	02013903          	ld	s2,32(sp)
    80002318:	01813983          	ld	s3,24(sp)
    8000231c:	01013a03          	ld	s4,16(sp)
    80002320:	00813a83          	ld	s5,8(sp)
    80002324:	04010113          	addi	sp,sp,64
    80002328:	00008067          	ret
        firstFreeBlock = newFreeBlock;
    8000232c:	00005797          	auipc	a5,0x5
    80002330:	0b27b223          	sd	s2,164(a5) # 800073d0 <_ZN15MemoryAllocator14firstFreeBlockE>
    return 0;
    80002334:	00000513          	li	a0,0
    80002338:	fd1ff06f          	j	80002308 <_ZN15MemoryAllocator10freeMemoryEPv+0xa8>
        return -1;
    8000233c:	fff00513          	li	a0,-1
}
    80002340:	00008067          	ret

0000000080002344 <_ZN15MemoryAllocator19getLargestFreeBlockEv>:

size_t  MemoryAllocator::getLargestFreeBlock()
{
    80002344:	ff010113          	addi	sp,sp,-16
    80002348:	00813423          	sd	s0,8(sp)
    8000234c:	01010413          	addi	s0,sp,16
    size_t largestBlock = firstFreeBlock->numOfBlocks;
    80002350:	00005797          	auipc	a5,0x5
    80002354:	0807b783          	ld	a5,128(a5) # 800073d0 <_ZN15MemoryAllocator14firstFreeBlockE>
    80002358:	0087b503          	ld	a0,8(a5)
    for(FreeBlock* curr = firstFreeBlock->nextBlock; curr; curr = curr->nextBlock)
    8000235c:	0107b783          	ld	a5,16(a5)
    80002360:	0080006f          	j	80002368 <_ZN15MemoryAllocator19getLargestFreeBlockEv+0x24>
    80002364:	0107b783          	ld	a5,16(a5)
    80002368:	00078a63          	beqz	a5,8000237c <_ZN15MemoryAllocator19getLargestFreeBlockEv+0x38>
    {
        if(curr->numOfBlocks > largestBlock)
    8000236c:	0087b703          	ld	a4,8(a5)
    80002370:	fee57ae3          	bgeu	a0,a4,80002364 <_ZN15MemoryAllocator19getLargestFreeBlockEv+0x20>
        {
            largestBlock = curr->numOfBlocks;
    80002374:	00070513          	mv	a0,a4
    80002378:	fedff06f          	j	80002364 <_ZN15MemoryAllocator19getLargestFreeBlockEv+0x20>
        }
    }
    return largestBlock * MEM_BLOCK_SIZE;
}
    8000237c:	00651513          	slli	a0,a0,0x6
    80002380:	00813403          	ld	s0,8(sp)
    80002384:	01010113          	addi	sp,sp,16
    80002388:	00008067          	ret

000000008000238c <_ZN15MemoryAllocator12getFreeSpaceEv>:
size_t MemoryAllocator::getFreeSpace()
{
    8000238c:	ff010113          	addi	sp,sp,-16
    80002390:	00813423          	sd	s0,8(sp)
    80002394:	01010413          	addi	s0,sp,16
    return numOfFreeBlocks * MEM_BLOCK_SIZE;
}
    80002398:	00005517          	auipc	a0,0x5
    8000239c:	03053503          	ld	a0,48(a0) # 800073c8 <_ZN15MemoryAllocator15numOfFreeBlocksE>
    800023a0:	00651513          	slli	a0,a0,0x6
    800023a4:	00813403          	ld	s0,8(sp)
    800023a8:	01010113          	addi	sp,sp,16
    800023ac:	00008067          	ret

00000000800023b0 <_ZN15MemoryAllocator17getSizeOfMetaDataEv>:

size_t MemoryAllocator::getSizeOfMetaData()
{
    800023b0:	ff010113          	addi	sp,sp,-16
    800023b4:	00813423          	sd	s0,8(sp)
    800023b8:	01010413          	addi	s0,sp,16
    return sizeof(OccupiedBlock);
    800023bc:	01000513          	li	a0,16
    800023c0:	00813403          	ld	s0,8(sp)
    800023c4:	01010113          	addi	sp,sp,16
    800023c8:	00008067          	ret

00000000800023cc <_ZN10KSemaphore19initializeSemaphoreEjP10ObjectPoolIS_Lm10EE>:

extern "C" void context_switch(TCB::Context* oldContext, TCB::Context* newContext);


void KSemaphore::initializeSemaphore(unsigned value, ObjectPool<KSemaphore, KernelConfig::NUM_OF_SEMAPHORES_IN_POOL>* pool)
{
    800023cc:	fe010113          	addi	sp,sp,-32
    800023d0:	00113c23          	sd	ra,24(sp)
    800023d4:	00813823          	sd	s0,16(sp)
    800023d8:	00913423          	sd	s1,8(sp)
    800023dc:	01213023          	sd	s2,0(sp)
    800023e0:	02010413          	addi	s0,sp,32
    800023e4:	00050493          	mv	s1,a0
    800023e8:	00060913          	mv	s2,a2
    semaphoreVal = value;
    800023ec:	02059593          	slli	a1,a1,0x20
    800023f0:	0205d593          	srli	a1,a1,0x20
    800023f4:	00b53023          	sd	a1,0(a0)
    //headBlockedThread = nullptr;
    //tailBlockedThread = nullptr;
    queueBlockedThreads = new Queue<TCB>();
    800023f8:	01000513          	li	a0,16
    800023fc:	fffff097          	auipc	ra,0xfffff
    80002400:	78c080e7          	jalr	1932(ra) # 80001b88 <_ZN5QueueI3TCBEnwEm>
    80002404:	00053023          	sd	zero,0(a0)
    80002408:	00053423          	sd	zero,8(a0)
    8000240c:	00a4b423          	sd	a0,8(s1)
    sourcePool = pool;
    80002410:	0124b823          	sd	s2,16(s1)
}
    80002414:	01813083          	ld	ra,24(sp)
    80002418:	01013403          	ld	s0,16(sp)
    8000241c:	00813483          	ld	s1,8(sp)
    80002420:	00013903          	ld	s2,0(sp)
    80002424:	02010113          	addi	sp,sp,32
    80002428:	00008067          	ret

000000008000242c <_ZN10KSemaphore11blockThreadEP3TCB>:

void KSemaphore::blockThread(TCB* threadToBlock)
{
    8000242c:	ff010113          	addi	sp,sp,-16
    80002430:	00113423          	sd	ra,8(sp)
    80002434:	00813023          	sd	s0,0(sp)
    80002438:	01010413          	addi	s0,sp,16
    void setSemaphoreOnWait (KSemaphore* semaphore) { waitOnSemaphore = semaphore; }
    8000243c:	04a5b023          	sd	a0,64(a1)
//    else
//    {
//        tailBlockedThread->addThreadToState(threadToBlock);
//    }
//    tailBlockedThread = threadToBlock;
    queueBlockedThreads->append(threadToBlock);
    80002440:	00853503          	ld	a0,8(a0)
    80002444:	fffff097          	auipc	ra,0xfffff
    80002448:	780080e7          	jalr	1920(ra) # 80001bc4 <_ZN5QueueI3TCBE6appendEPS0_>
}
    8000244c:	00813083          	ld	ra,8(sp)
    80002450:	00013403          	ld	s0,0(sp)
    80002454:	01010113          	addi	sp,sp,16
    80002458:	00008067          	ret

000000008000245c <_ZN10KSemaphore4waitEv>:

}

int KSemaphore::wait()
{
    semaphoreVal--;
    8000245c:	00053783          	ld	a5,0(a0)
    80002460:	fff78793          	addi	a5,a5,-1
    80002464:	00f53023          	sd	a5,0(a0)
    if(semaphoreVal < 0)
    80002468:	0007c663          	bltz	a5,80002474 <_ZN10KSemaphore4waitEv+0x18>
        {
            return -1;
        }

    }
    return 0;
    8000246c:	00000513          	li	a0,0
}
    80002470:	00008067          	ret
{
    80002474:	fd010113          	addi	sp,sp,-48
    80002478:	02113423          	sd	ra,40(sp)
    8000247c:	02813023          	sd	s0,32(sp)
    80002480:	00913c23          	sd	s1,24(sp)
    80002484:	01213823          	sd	s2,16(sp)
    80002488:	01313423          	sd	s3,8(sp)
    8000248c:	03010413          	addi	s0,sp,48
    80002490:	00050493          	mv	s1,a0
    static TCB* getRunningThread() { return running; }
    80002494:	00005917          	auipc	s2,0x5
    80002498:	e5c93903          	ld	s2,-420(s2) # 800072f0 <_GLOBAL_OFFSET_TABLE_+0x60>
    8000249c:	00093983          	ld	s3,0(s2)
        TCB::setRunningThread(Scheduler::get());
    800024a0:	00000097          	auipc	ra,0x0
    800024a4:	8c4080e7          	jalr	-1852(ra) # 80001d64 <_ZN9Scheduler3getEv>
    static void setRunningThread(TCB* newRunningThread) { running = newRunningThread; }
    800024a8:	00a93023          	sd	a0,0(s2)
    void resetState() {state = nullptr; }
    800024ac:	0409b423          	sd	zero,72(s3)
        blockThread(oldThread);
    800024b0:	00098593          	mv	a1,s3
    800024b4:	00048513          	mv	a0,s1
    800024b8:	00000097          	auipc	ra,0x0
    800024bc:	f74080e7          	jalr	-140(ra) # 8000242c <_ZN10KSemaphore11blockThreadEP3TCB>
    static TCB* getRunningThread() { return running; }
    800024c0:	00093583          	ld	a1,0(s2)
        context_switch(oldThread->getContext(), TCB::getRunningThread()->getContext());
    800024c4:	00858593          	addi	a1,a1,8
    800024c8:	00898513          	addi	a0,s3,8
    800024cc:	fffff097          	auipc	ra,0xfffff
    800024d0:	cd4080e7          	jalr	-812(ra) # 800011a0 <context_switch>
    800024d4:	00093783          	ld	a5,0(s2)
    KernelConfig::WakeUpReason getWakeUpReason() { return wakeUpReason; }
    800024d8:	0547a783          	lw	a5,84(a5)
        if(TCB::getRunningThread()->getWakeUpReason() == KernelConfig::WAKE_UP_SEMAPHORE_SIGNAL)
    800024dc:	02078663          	beqz	a5,80002508 <_ZN10KSemaphore4waitEv+0xac>
        if(TCB::getRunningThread()->getWakeUpReason() == KernelConfig::WAKE_UP_SEMAPHORE_CLOSE)
    800024e0:	00100713          	li	a4,1
    800024e4:	02e78663          	beq	a5,a4,80002510 <_ZN10KSemaphore4waitEv+0xb4>
    return 0;
    800024e8:	00000513          	li	a0,0
}
    800024ec:	02813083          	ld	ra,40(sp)
    800024f0:	02013403          	ld	s0,32(sp)
    800024f4:	01813483          	ld	s1,24(sp)
    800024f8:	01013903          	ld	s2,16(sp)
    800024fc:	00813983          	ld	s3,8(sp)
    80002500:	03010113          	addi	sp,sp,48
    80002504:	00008067          	ret
            return 0;
    80002508:	00000513          	li	a0,0
    8000250c:	fe1ff06f          	j	800024ec <_ZN10KSemaphore4waitEv+0x90>
            return -1;
    80002510:	fff00513          	li	a0,-1
    80002514:	fd9ff06f          	j	800024ec <_ZN10KSemaphore4waitEv+0x90>

0000000080002518 <_ZN10KSemaphore13unblockThreadEN12KernelConfig12WakeUpReasonE>:
{
    80002518:	fe010113          	addi	sp,sp,-32
    8000251c:	00113c23          	sd	ra,24(sp)
    80002520:	00813823          	sd	s0,16(sp)
    80002524:	00913423          	sd	s1,8(sp)
    80002528:	02010413          	addi	s0,sp,32
    8000252c:	00058493          	mv	s1,a1
   TCB* oldThread = queueBlockedThreads->take();
    80002530:	00853503          	ld	a0,8(a0)
    80002534:	fffff097          	auipc	ra,0xfffff
    80002538:	6c4080e7          	jalr	1732(ra) # 80001bf8 <_ZN5QueueI3TCBE4takeEv>
    if(oldThread)
    8000253c:	02050863          	beqz	a0,8000256c <_ZN10KSemaphore13unblockThreadEN12KernelConfig12WakeUpReasonE+0x54>
    void setWakeUpReason(KernelConfig::WakeUpReason reason) { wakeUpReason = reason; }
    80002540:	04952a23          	sw	s1,84(a0)
    void resetState() {state = nullptr; }
    80002544:	04053423          	sd	zero,72(a0)
    void resetSemaphoreOnWait() { waitOnSemaphore = nullptr; }
    80002548:	04053023          	sd	zero,64(a0)
        Scheduler::put(oldThread);
    8000254c:	fffff097          	auipc	ra,0xfffff
    80002550:	7e4080e7          	jalr	2020(ra) # 80001d30 <_ZN9Scheduler3putEP3TCB>
        return 0;
    80002554:	00000513          	li	a0,0
}
    80002558:	01813083          	ld	ra,24(sp)
    8000255c:	01013403          	ld	s0,16(sp)
    80002560:	00813483          	ld	s1,8(sp)
    80002564:	02010113          	addi	sp,sp,32
    80002568:	00008067          	ret
    return -1;
    8000256c:	fff00513          	li	a0,-1
    80002570:	fe9ff06f          	j	80002558 <_ZN10KSemaphore13unblockThreadEN12KernelConfig12WakeUpReasonE+0x40>

0000000080002574 <_ZN10KSemaphore6signalEv>:

int KSemaphore::signal()
{
    semaphoreVal++;
    80002574:	00053783          	ld	a5,0(a0)
    80002578:	00178793          	addi	a5,a5,1
    8000257c:	00f53023          	sd	a5,0(a0)
    if(semaphoreVal <= 0)
    80002580:	00f05663          	blez	a5,8000258c <_ZN10KSemaphore6signalEv+0x18>
    {
        return unblockThread(KernelConfig::WAKE_UP_SEMAPHORE_SIGNAL);
    }
    return 0;
    80002584:	00000513          	li	a0,0
}
    80002588:	00008067          	ret
{
    8000258c:	ff010113          	addi	sp,sp,-16
    80002590:	00113423          	sd	ra,8(sp)
    80002594:	00813023          	sd	s0,0(sp)
    80002598:	01010413          	addi	s0,sp,16
        return unblockThread(KernelConfig::WAKE_UP_SEMAPHORE_SIGNAL);
    8000259c:	00000593          	li	a1,0
    800025a0:	00000097          	auipc	ra,0x0
    800025a4:	f78080e7          	jalr	-136(ra) # 80002518 <_ZN10KSemaphore13unblockThreadEN12KernelConfig12WakeUpReasonE>
}
    800025a8:	00813083          	ld	ra,8(sp)
    800025ac:	00013403          	ld	s0,0(sp)
    800025b0:	01010113          	addi	sp,sp,16
    800025b4:	00008067          	ret

00000000800025b8 <_ZN10KSemaphore5closeEv>:

int KSemaphore::close()
{
    800025b8:	fe010113          	addi	sp,sp,-32
    800025bc:	00113c23          	sd	ra,24(sp)
    800025c0:	00813823          	sd	s0,16(sp)
    800025c4:	00913423          	sd	s1,8(sp)
    800025c8:	01213023          	sd	s2,0(sp)
    800025cc:	02010413          	addi	s0,sp,32
    800025d0:	00050913          	mv	s2,a0
    TCB* tempThread = queueBlockedThreads->top();
    800025d4:	00853783          	ld	a5,8(a0)
    T* top() const { return head; };
    800025d8:	0007b483          	ld	s1,0(a5)
    if(!tempThread)
    800025dc:	02048063          	beqz	s1,800025fc <_ZN10KSemaphore5closeEv+0x44>
    {
        return 0;
    }
    for(;tempThread; tempThread = tempThread->getState())
    800025e0:	02048263          	beqz	s1,80002604 <_ZN10KSemaphore5closeEv+0x4c>
    {
        unblockThread(KernelConfig::WAKE_UP_SEMAPHORE_CLOSE);
    800025e4:	00100593          	li	a1,1
    800025e8:	00090513          	mv	a0,s2
    800025ec:	00000097          	auipc	ra,0x0
    800025f0:	f2c080e7          	jalr	-212(ra) # 80002518 <_ZN10KSemaphore13unblockThreadEN12KernelConfig12WakeUpReasonE>
    TCB* getState() const { return state; }
    800025f4:	0484b483          	ld	s1,72(s1)
    for(;tempThread; tempThread = tempThread->getState())
    800025f8:	fe9ff06f          	j	800025e0 <_ZN10KSemaphore5closeEv+0x28>
        return 0;
    800025fc:	00000513          	li	a0,0
    80002600:	0080006f          	j	80002608 <_ZN10KSemaphore5closeEv+0x50>
    }
    return -1;
    80002604:	fff00513          	li	a0,-1

}
    80002608:	01813083          	ld	ra,24(sp)
    8000260c:	01013403          	ld	s0,16(sp)
    80002610:	00813483          	ld	s1,8(sp)
    80002614:	00013903          	ld	s2,0(sp)
    80002618:	02010113          	addi	sp,sp,32
    8000261c:	00008067          	ret

0000000080002620 <_ZN10KSemaphore28removeThreadFromBlockedQueueEP3TCB>:
void KSemaphore::removeThreadFromBlockedQueue(TCB *thread)
{
    80002620:	fe010113          	addi	sp,sp,-32
    80002624:	00113c23          	sd	ra,24(sp)
    80002628:	00813823          	sd	s0,16(sp)
    8000262c:	00913423          	sd	s1,8(sp)
    80002630:	02010413          	addi	s0,sp,32
    80002634:	00058493          	mv	s1,a1
//        {
//            tailBlockedThread = prevThread;
//        }
//    }

    queueBlockedThreads->removeElement(thread);
    80002638:	00853503          	ld	a0,8(a0)
    8000263c:	00000097          	auipc	ra,0x0
    80002640:	024080e7          	jalr	36(ra) # 80002660 <_ZN5QueueI3TCBE13removeElementEPS0_>
    void resetSemaphoreOnWait() { waitOnSemaphore = nullptr; }
    80002644:	0404b023          	sd	zero,64(s1)
    void resetState() {state = nullptr; }
    80002648:	0404b423          	sd	zero,72(s1)
    thread->resetSemaphoreOnWait();
    thread->resetState();

    8000264c:	01813083          	ld	ra,24(sp)
    80002650:	01013403          	ld	s0,16(sp)
    80002654:	00813483          	ld	s1,8(sp)
    80002658:	02010113          	addi	sp,sp,32
    8000265c:	00008067          	ret

0000000080002660 <_ZN5QueueI3TCBE13removeElementEPS0_>:
void Queue<T>::removeElement(T *element)
    80002660:	ff010113          	addi	sp,sp,-16
    80002664:	00813423          	sd	s0,8(sp)
    80002668:	01010413          	addi	s0,sp,16
    T* prev = nullptr, * curr = head;
    8000266c:	00053683          	ld	a3,0(a0)
    80002670:	00068793          	mv	a5,a3
    80002674:	00000713          	li	a4,0
    while(element != curr && curr)
    80002678:	00b78a63          	beq	a5,a1,8000268c <_ZN5QueueI3TCBE13removeElementEPS0_+0x2c>
    8000267c:	00078863          	beqz	a5,8000268c <_ZN5QueueI3TCBE13removeElementEPS0_+0x2c>
        prev = curr;
    80002680:	00078713          	mv	a4,a5
        curr = curr->getState();
    80002684:	0487b783          	ld	a5,72(a5)
    while(element != curr && curr)
    80002688:	ff1ff06f          	j	80002678 <_ZN5QueueI3TCBE13removeElementEPS0_+0x18>
    if(!prev)
    8000268c:	02070063          	beqz	a4,800026ac <_ZN5QueueI3TCBE13removeElementEPS0_+0x4c>
    TCB* getState() const { return state; }
    80002690:	0485b783          	ld	a5,72(a1)
    void addThreadToState(TCB* newThread) { state = newThread; }
    80002694:	04f73423          	sd	a5,72(a4)
        if(element == tail)
    80002698:	00853783          	ld	a5,8(a0)
    8000269c:	02b78263          	beq	a5,a1,800026c0 <_ZN5QueueI3TCBE13removeElementEPS0_+0x60>
}
    800026a0:	00813403          	ld	s0,8(sp)
    800026a4:	01010113          	addi	sp,sp,16
    800026a8:	00008067          	ret
    TCB* getState() const { return state; }
    800026ac:	0486b783          	ld	a5,72(a3)
        head = head->getState();
    800026b0:	00f53023          	sd	a5,0(a0)
        if(!head)
    800026b4:	fe0796e3          	bnez	a5,800026a0 <_ZN5QueueI3TCBE13removeElementEPS0_+0x40>
            tail = nullptr;
    800026b8:	00053423          	sd	zero,8(a0)
    800026bc:	fe5ff06f          	j	800026a0 <_ZN5QueueI3TCBE13removeElementEPS0_+0x40>
            tail = prev;
    800026c0:	00e53423          	sd	a4,8(a0)
}
    800026c4:	fddff06f          	j	800026a0 <_ZN5QueueI3TCBE13removeElementEPS0_+0x40>

00000000800026c8 <_ZN6Kernel12kernelWorkerEPv>:
    }

}

void Kernel::kernelWorker(void*)
{
    800026c8:	ff010113          	addi	sp,sp,-16
    800026cc:	00813423          	sd	s0,8(sp)
    800026d0:	01010413          	addi	s0,sp,16
    while(1)
    800026d4:	0000006f          	j	800026d4 <_ZN6Kernel12kernelWorkerEPv+0xc>

00000000800026d8 <_ZN13PriorityQueueI3TCBUlPS0_S1_E_E3topEv>:
    size_t numOfBlocks = size / MEM_BLOCK_SIZE;
    numOfBlocks += size % MEM_BLOCK_SIZE ? 1 : 0;
    return MemoryAllocator::allocateMemory(numOfBlocks);
}
template<typename T, typename Compare>
T* PriorityQueue<T, Compare>::top()
    800026d8:	ff010113          	addi	sp,sp,-16
    800026dc:	00813423          	sd	s0,8(sp)
    800026e0:	01010413          	addi	s0,sp,16
{
    return head;
}
    800026e4:	00053503          	ld	a0,0(a0)
    800026e8:	00813403          	ld	s0,8(sp)
    800026ec:	01010113          	addi	sp,sp,16
    800026f0:	00008067          	ret

00000000800026f4 <_ZN13PriorityQueueI3TCBUlPS0_S1_E_E4takeEv>:
T* PriorityQueue<T, Compare>::take()
    800026f4:	ff010113          	addi	sp,sp,-16
    800026f8:	00813423          	sd	s0,8(sp)
    800026fc:	01010413          	addi	s0,sp,16
    80002700:	00050793          	mv	a5,a0
    T* oldElement = head;
    80002704:	00053503          	ld	a0,0(a0)
    80002708:	04853703          	ld	a4,72(a0)
    head = head->getState();
    8000270c:	00e7b023          	sd	a4,0(a5)
    if(!head)
    80002710:	00070863          	beqz	a4,80002720 <_ZN13PriorityQueueI3TCBUlPS0_S1_E_E4takeEv+0x2c>
}
    80002714:	00813403          	ld	s0,8(sp)
    80002718:	01010113          	addi	sp,sp,16
    8000271c:	00008067          	ret
        tail = nullptr;
    80002720:	0007b423          	sd	zero,8(a5)
    return oldElement;
    80002724:	ff1ff06f          	j	80002714 <_ZN13PriorityQueueI3TCBUlPS0_S1_E_E4takeEv+0x20>

0000000080002728 <_ZN13PriorityQueueI3TCBUlPS0_S1_E_E6appendES1_>:
void PriorityQueue<T, Compare>::append(T *newElement)
    80002728:	ff010113          	addi	sp,sp,-16
    8000272c:	00813423          	sd	s0,8(sp)
    80002730:	01010413          	addi	s0,sp,16
    if(head == nullptr)
    80002734:	00053783          	ld	a5,0(a0)
    80002738:	02078863          	beqz	a5,80002768 <_ZN13PriorityQueueI3TCBUlPS0_S1_E_E6appendES1_+0x40>
    T* curr = head, *prev = nullptr;
    8000273c:	00053783          	ld	a5,0(a0)
    80002740:	00000613          	li	a2,0
    while(curr && cmp(curr, newElement))
    80002744:	02078663          	beqz	a5,80002770 <_ZN13PriorityQueueI3TCBUlPS0_S1_E_E6appendES1_+0x48>
    size_t getTimeToSleep() const { return timeToSleep; }
    80002748:	0587b683          	ld	a3,88(a5)
    8000274c:	0585b703          	ld	a4,88(a1)
    80002750:	02e6f063          	bgeu	a3,a4,80002770 <_ZN13PriorityQueueI3TCBUlPS0_S1_E_E6appendES1_+0x48>
        newElement->setTimeToSleep(newElement->getTimeToSleep() - curr->getTimeToSleep());
    80002754:	40d70733          	sub	a4,a4,a3
    void setTimeToSleep(size_t time) { timeToSleep = time; }
    80002758:	04e5bc23          	sd	a4,88(a1)
        prev = curr;
    8000275c:	00078613          	mv	a2,a5
        curr = curr->getState();
    80002760:	0487b783          	ld	a5,72(a5)
    while(curr && cmp(curr, newElement))
    80002764:	fe1ff06f          	j	80002744 <_ZN13PriorityQueueI3TCBUlPS0_S1_E_E6appendES1_+0x1c>
        head = newElement;
    80002768:	00b53023          	sd	a1,0(a0)
    8000276c:	fd1ff06f          	j	8000273c <_ZN13PriorityQueueI3TCBUlPS0_S1_E_E6appendES1_+0x14>
    if(curr == head)
    80002770:	00053703          	ld	a4,0(a0)
    80002774:	02f70463          	beq	a4,a5,8000279c <_ZN13PriorityQueueI3TCBUlPS0_S1_E_E6appendES1_+0x74>
    void addThreadToState(TCB* newThread) { state = newThread; }
    80002778:	04f5b423          	sd	a5,72(a1)
    8000277c:	04b63423          	sd	a1,72(a2)
    size_t getTimeToSleep() const { return timeToSleep; }
    80002780:	0587b703          	ld	a4,88(a5)
    80002784:	0585b683          	ld	a3,88(a1)
        curr->setTimeToSleep(curr->getTimeToSleep() - newElement->getTimeToSleep());
    80002788:	40d70733          	sub	a4,a4,a3
    void setTimeToSleep(size_t time) { timeToSleep = time; }
    8000278c:	04e7bc23          	sd	a4,88(a5)
}
    80002790:	00813403          	ld	s0,8(sp)
    80002794:	01010113          	addi	sp,sp,16
    80002798:	00008067          	ret
    void addThreadToState(TCB* newThread) { state = newThread; }
    8000279c:	04e5b423          	sd	a4,72(a1)
    size_t getTimeToSleep() const { return timeToSleep; }
    800027a0:	05873783          	ld	a5,88(a4)
    800027a4:	0585b683          	ld	a3,88(a1)
        head->setTimeToSleep(head->getTimeToSleep() - newElement->getTimeToSleep());
    800027a8:	40d787b3          	sub	a5,a5,a3
    void setTimeToSleep(size_t time) { timeToSleep = time; }
    800027ac:	04f73c23          	sd	a5,88(a4)
        head = newElement;
    800027b0:	00b53023          	sd	a1,0(a0)
    800027b4:	fddff06f          	j	80002790 <_ZN13PriorityQueueI3TCBUlPS0_S1_E_E6appendES1_+0x68>

00000000800027b8 <_ZN6Kernel9sysMallocEPNS_21ArgumentsOfSystemCallE>:

    }
}

uint64 Kernel::sysMalloc(Kernel::ArgumentsOfSystemCall *arg)
{
    800027b8:	ff010113          	addi	sp,sp,-16
    800027bc:	00113423          	sd	ra,8(sp)
    800027c0:	00813023          	sd	s0,0(sp)
    800027c4:	01010413          	addi	s0,sp,16
//    uint64 returnValue;
//    returnValue = (uint64)MemoryAllocator::allocateMemory(arg->a0);
//    return returnValue;
    return (uint64)MemoryAllocator::allocateMemory(arg->a0);
    800027c8:	00053503          	ld	a0,0(a0)
    800027cc:	00000097          	auipc	ra,0x0
    800027d0:	938080e7          	jalr	-1736(ra) # 80002104 <_ZN15MemoryAllocator14allocateMemoryEm>
}
    800027d4:	00813083          	ld	ra,8(sp)
    800027d8:	00013403          	ld	s0,0(sp)
    800027dc:	01010113          	addi	sp,sp,16
    800027e0:	00008067          	ret

00000000800027e4 <_ZN13PriorityQueueI3TCBUlPS0_S1_E_EnwEm>:
void* PriorityQueue<T, Compare>::operator new(size_t size)
    800027e4:	ff010113          	addi	sp,sp,-16
    800027e8:	00113423          	sd	ra,8(sp)
    800027ec:	00813023          	sd	s0,0(sp)
    800027f0:	01010413          	addi	s0,sp,16
    size_t numOfBlocks = size / MEM_BLOCK_SIZE;
    800027f4:	00655793          	srli	a5,a0,0x6
    numOfBlocks += size % MEM_BLOCK_SIZE ? 1 : 0;
    800027f8:	03f57513          	andi	a0,a0,63
    800027fc:	00050463          	beqz	a0,80002804 <_ZN13PriorityQueueI3TCBUlPS0_S1_E_EnwEm+0x20>
    80002800:	00100513          	li	a0,1
    return MemoryAllocator::allocateMemory(numOfBlocks);
    80002804:	00f50533          	add	a0,a0,a5
    80002808:	00000097          	auipc	ra,0x0
    8000280c:	8fc080e7          	jalr	-1796(ra) # 80002104 <_ZN15MemoryAllocator14allocateMemoryEm>
}
    80002810:	00813083          	ld	ra,8(sp)
    80002814:	00013403          	ld	s0,0(sp)
    80002818:	01010113          	addi	sp,sp,16
    8000281c:	00008067          	ret

0000000080002820 <_ZN6Kernel7sysFreeEPNS_21ArgumentsOfSystemCallE>:
uint64 Kernel::sysFree(Kernel::ArgumentsOfSystemCall *arg)
{
    80002820:	ff010113          	addi	sp,sp,-16
    80002824:	00113423          	sd	ra,8(sp)
    80002828:	00813023          	sd	s0,0(sp)
    8000282c:	01010413          	addi	s0,sp,16
//    uint64 returnValue;
//    returnValue = (uint64)MemoryAllocator::freeMemory((void*)arg->a0);
//    return returnValue;
    return (uint64)MemoryAllocator::freeMemory((void*)arg->a0);
    80002830:	00053503          	ld	a0,0(a0)
    80002834:	00000097          	auipc	ra,0x0
    80002838:	a2c080e7          	jalr	-1492(ra) # 80002260 <_ZN15MemoryAllocator10freeMemoryEPv>
}
    8000283c:	00813083          	ld	ra,8(sp)
    80002840:	00013403          	ld	s0,0(sp)
    80002844:	01010113          	addi	sp,sp,16
    80002848:	00008067          	ret

000000008000284c <_ZN6Kernel15sysGetFreeSpaceEPNS_21ArgumentsOfSystemCallE>:
uint64 Kernel::sysGetFreeSpace(Kernel::ArgumentsOfSystemCall *arg)
{
    8000284c:	ff010113          	addi	sp,sp,-16
    80002850:	00113423          	sd	ra,8(sp)
    80002854:	00813023          	sd	s0,0(sp)
    80002858:	01010413          	addi	s0,sp,16
//    uint64 returnValue;
//    returnValue = (uint64)MemoryAllocator::getFreeSpace();
//    return returnValue;
    return (uint64)MemoryAllocator::getFreeSpace();
    8000285c:	00000097          	auipc	ra,0x0
    80002860:	b30080e7          	jalr	-1232(ra) # 8000238c <_ZN15MemoryAllocator12getFreeSpaceEv>
}
    80002864:	00813083          	ld	ra,8(sp)
    80002868:	00013403          	ld	s0,0(sp)
    8000286c:	01010113          	addi	sp,sp,16
    80002870:	00008067          	ret

0000000080002874 <_ZN6Kernel19sysLargestFreeBlockEPNS_21ArgumentsOfSystemCallE>:
uint64 Kernel::sysLargestFreeBlock(Kernel::ArgumentsOfSystemCall *arg)
{
    80002874:	ff010113          	addi	sp,sp,-16
    80002878:	00113423          	sd	ra,8(sp)
    8000287c:	00813023          	sd	s0,0(sp)
    80002880:	01010413          	addi	s0,sp,16
//    uint64 returnValue;
//    returnValue = (uint64)MemoryAllocator::getLargestFreeBlock();
//    return (uint64)MemoryAllocator;
    return (uint64)MemoryAllocator::getLargestFreeBlock();
    80002884:	00000097          	auipc	ra,0x0
    80002888:	ac0080e7          	jalr	-1344(ra) # 80002344 <_ZN15MemoryAllocator19getLargestFreeBlockEv>
}
    8000288c:	00813083          	ld	ra,8(sp)
    80002890:	00013403          	ld	s0,0(sp)
    80002894:	01010113          	addi	sp,sp,16
    80002898:	00008067          	ret

000000008000289c <_ZN6Kernel16sysSemaphoreWaitEPNS_21ArgumentsOfSystemCallE>:
    Kernel::poolOfSemaphores->freeObject(tempSemaphore);
    return returnValue;
}

uint64 Kernel::sysSemaphoreWait(ArgumentsOfSystemCall *arg)
{
    8000289c:	ff010113          	addi	sp,sp,-16
    800028a0:	00113423          	sd	ra,8(sp)
    800028a4:	00813023          	sd	s0,0(sp)
    800028a8:	01010413          	addi	s0,sp,16
    KSemaphore* tempSemaphore = (KSemaphore*)(arg->a0);
    return (uint64)tempSemaphore->wait();
    800028ac:	00053503          	ld	a0,0(a0)
    800028b0:	00000097          	auipc	ra,0x0
    800028b4:	bac080e7          	jalr	-1108(ra) # 8000245c <_ZN10KSemaphore4waitEv>
}
    800028b8:	00813083          	ld	ra,8(sp)
    800028bc:	00013403          	ld	s0,0(sp)
    800028c0:	01010113          	addi	sp,sp,16
    800028c4:	00008067          	ret

00000000800028c8 <_ZN6Kernel18sysSemaphoreSignalEPNS_21ArgumentsOfSystemCallE>:

uint64 Kernel::sysSemaphoreSignal(ArgumentsOfSystemCall *arg)
{
    800028c8:	ff010113          	addi	sp,sp,-16
    800028cc:	00113423          	sd	ra,8(sp)
    800028d0:	00813023          	sd	s0,0(sp)
    800028d4:	01010413          	addi	s0,sp,16
    KSemaphore* tempSemaphore = (KSemaphore*)(arg->a0);
    return (uint64)tempSemaphore->signal();
    800028d8:	00053503          	ld	a0,0(a0)
    800028dc:	00000097          	auipc	ra,0x0
    800028e0:	c98080e7          	jalr	-872(ra) # 80002574 <_ZN10KSemaphore6signalEv>
}
    800028e4:	00813083          	ld	ra,8(sp)
    800028e8:	00013403          	ld	s0,0(sp)
    800028ec:	01010113          	addi	sp,sp,16
    800028f0:	00008067          	ret

00000000800028f4 <_ZN6Kernel12sysTimeSleepEPNS_21ArgumentsOfSystemCallE>:

uint64 Kernel::sysTimeSleep(ArgumentsOfSystemCall *arg)
{
    800028f4:	fe010113          	addi	sp,sp,-32
    800028f8:	00113c23          	sd	ra,24(sp)
    800028fc:	00813823          	sd	s0,16(sp)
    80002900:	00913423          	sd	s1,8(sp)
    80002904:	01213023          	sd	s2,0(sp)
    80002908:	02010413          	addi	s0,sp,32
    static TCB* getRunningThread() { return running; }
    8000290c:	00005917          	auipc	s2,0x5
    80002910:	9e493903          	ld	s2,-1564(s2) # 800072f0 <_GLOBAL_OFFSET_TABLE_+0x60>
    80002914:	00093483          	ld	s1,0(s2)
    void resetState() {state = nullptr; }
    80002918:	0404b423          	sd	zero,72(s1)
    TCB* oldThread = TCB::getRunningThread();
    oldThread->resetState();
    oldThread->setTimeToSleep((size_t)arg->a0);
    8000291c:	00053783          	ld	a5,0(a0)
    void setTimeToSleep(size_t time) { timeToSleep = time; }
    80002920:	04f4bc23          	sd	a5,88(s1)
    queueOfAsleepThreads->append(oldThread);
    80002924:	00048593          	mv	a1,s1
    80002928:	00005517          	auipc	a0,0x5
    8000292c:	ab853503          	ld	a0,-1352(a0) # 800073e0 <_ZN6Kernel20queueOfAsleepThreadsE>
    80002930:	00000097          	auipc	ra,0x0
    80002934:	df8080e7          	jalr	-520(ra) # 80002728 <_ZN13PriorityQueueI3TCBUlPS0_S1_E_E6appendES1_>
    TCB::setRunningThread(Scheduler::get());
    80002938:	fffff097          	auipc	ra,0xfffff
    8000293c:	42c080e7          	jalr	1068(ra) # 80001d64 <_ZN9Scheduler3getEv>
    static void setRunningThread(TCB* newRunningThread) { running = newRunningThread; }
    80002940:	00a93023          	sd	a0,0(s2)
    context_switch(oldThread->getContext(), TCB::getRunningThread()->getContext());
    80002944:	00850593          	addi	a1,a0,8
    80002948:	00848513          	addi	a0,s1,8
    8000294c:	fffff097          	auipc	ra,0xfffff
    80002950:	854080e7          	jalr	-1964(ra) # 800011a0 <context_switch>
    return 0;
}
    80002954:	00000513          	li	a0,0
    80002958:	01813083          	ld	ra,24(sp)
    8000295c:	01013403          	ld	s0,16(sp)
    80002960:	00813483          	ld	s1,8(sp)
    80002964:	00013903          	ld	s2,0(sp)
    80002968:	02010113          	addi	sp,sp,32
    8000296c:	00008067          	ret

0000000080002970 <_ZN6Kernel19initializeArgumentsEPNS_21ArgumentsOfSystemCallEm>:
{
    80002970:	ff010113          	addi	sp,sp,-16
    80002974:	00813423          	sd	s0,8(sp)
    80002978:	01010413          	addi	s0,sp,16
    __asm__ volatile("ld %[rd], 11*8(%[rs])":[rd]"=r"(arg->a0):[rs]"r"(basePointer));
    8000297c:	0585b783          	ld	a5,88(a1)
    80002980:	00f53023          	sd	a5,0(a0)
    __asm__ volatile("ld %[rd], 12*8(%[rs])":[rd]"=r"(arg->a1):[rs]"r"(basePointer));
    80002984:	0605b783          	ld	a5,96(a1)
    80002988:	00f53423          	sd	a5,8(a0)
    __asm__ volatile("ld %[rd], 13*8(%[rs])":[rd]"=r"(arg->a2):[rs]"r"(basePointer));
    8000298c:	0685b783          	ld	a5,104(a1)
    80002990:	00f53823          	sd	a5,16(a0)
    __asm__ volatile("ld %[rd], 14*8(%[rs])":[rd]"=r"(arg->a3):[rs]"r"(basePointer));
    80002994:	0705b783          	ld	a5,112(a1)
    80002998:	00f53c23          	sd	a5,24(a0)
    __asm__ volatile("ld %[rd], 15*8(%[rs])":[rd]"=r"(arg->a4):[rs]"r"(basePointer));
    8000299c:	0785b783          	ld	a5,120(a1)
    800029a0:	02f53023          	sd	a5,32(a0)
    __asm__ volatile("ld %[rd], 16*8(%[rs])":[rd]"=r"(arg->a5):[rs]"r"(basePointer));
    800029a4:	0805b783          	ld	a5,128(a1)
    800029a8:	02f53423          	sd	a5,40(a0)
    __asm__ volatile("ld %[rd], 17*8(%[rs])":[rd]"=r"(arg->a6):[rs]"r"(basePointer));
    800029ac:	0885b583          	ld	a1,136(a1)
    800029b0:	02b53823          	sd	a1,48(a0)
}
    800029b4:	00813403          	ld	s0,8(sp)
    800029b8:	01010113          	addi	sp,sp,16
    800029bc:	00008067          	ret

00000000800029c0 <_ZN6Kernel17mallocSystemStackEm>:
{
    800029c0:	ff010113          	addi	sp,sp,-16
    800029c4:	00113423          	sd	ra,8(sp)
    800029c8:	00813023          	sd	s0,0(sp)
    800029cc:	01010413          	addi	s0,sp,16
    size_t numOfBlocks = numOfBytes / MEM_BLOCK_SIZE;
    800029d0:	00655793          	srli	a5,a0,0x6
    numOfBlocks += numOfBytes % MEM_BLOCK_SIZE ? 1 : 0;
    800029d4:	03f57513          	andi	a0,a0,63
    800029d8:	00050463          	beqz	a0,800029e0 <_ZN6Kernel17mallocSystemStackEm+0x20>
    800029dc:	00100513          	li	a0,1
    uint8* systemStack = (uint8*)MemoryAllocator::allocateMemory(numOfBlocks);
    800029e0:	00f50533          	add	a0,a0,a5
    800029e4:	fffff097          	auipc	ra,0xfffff
    800029e8:	720080e7          	jalr	1824(ra) # 80002104 <_ZN15MemoryAllocator14allocateMemoryEm>
}
    800029ec:	40050513          	addi	a0,a0,1024
    800029f0:	00813083          	ld	ra,8(sp)
    800029f4:	00013403          	ld	s0,0(sp)
    800029f8:	01010113          	addi	sp,sp,16
    800029fc:	00008067          	ret

0000000080002a00 <_ZN6Kernel13wakeUpThreadsEv>:
{
    80002a00:	fe010113          	addi	sp,sp,-32
    80002a04:	00113c23          	sd	ra,24(sp)
    80002a08:	00813823          	sd	s0,16(sp)
    80002a0c:	00913423          	sd	s1,8(sp)
    80002a10:	02010413          	addi	s0,sp,32
    queueOfAsleepThreads->top()->decrementTimeToSleep();
    80002a14:	00005517          	auipc	a0,0x5
    80002a18:	9cc53503          	ld	a0,-1588(a0) # 800073e0 <_ZN6Kernel20queueOfAsleepThreadsE>
    80002a1c:	00000097          	auipc	ra,0x0
    80002a20:	cbc080e7          	jalr	-836(ra) # 800026d8 <_ZN13PriorityQueueI3TCBUlPS0_S1_E_E3topEv>
    void decrementTimeToSleep() { timeToSleep--; };
    80002a24:	05853783          	ld	a5,88(a0)
    80002a28:	fff78793          	addi	a5,a5,-1
    80002a2c:	04f53c23          	sd	a5,88(a0)
    while(!queueOfAsleepThreads->top()->getTimeToSleep())
    80002a30:	00005497          	auipc	s1,0x5
    80002a34:	9b04b483          	ld	s1,-1616(s1) # 800073e0 <_ZN6Kernel20queueOfAsleepThreadsE>
    80002a38:	00048513          	mv	a0,s1
    80002a3c:	00000097          	auipc	ra,0x0
    80002a40:	c9c080e7          	jalr	-868(ra) # 800026d8 <_ZN13PriorityQueueI3TCBUlPS0_S1_E_E3topEv>
    size_t getTimeToSleep() const { return timeToSleep; }
    80002a44:	05853783          	ld	a5,88(a0)
    80002a48:	02079063          	bnez	a5,80002a68 <_ZN6Kernel13wakeUpThreadsEv+0x68>
        TCB* curr = queueOfAsleepThreads->take();
    80002a4c:	00048513          	mv	a0,s1
    80002a50:	00000097          	auipc	ra,0x0
    80002a54:	ca4080e7          	jalr	-860(ra) # 800026f4 <_ZN13PriorityQueueI3TCBUlPS0_S1_E_E4takeEv>
    void resetState() {state = nullptr; }
    80002a58:	04053423          	sd	zero,72(a0)
        Scheduler::put(curr);
    80002a5c:	fffff097          	auipc	ra,0xfffff
    80002a60:	2d4080e7          	jalr	724(ra) # 80001d30 <_ZN9Scheduler3putEP3TCB>
    while(!queueOfAsleepThreads->top()->getTimeToSleep())
    80002a64:	fcdff06f          	j	80002a30 <_ZN6Kernel13wakeUpThreadsEv+0x30>
}
    80002a68:	01813083          	ld	ra,24(sp)
    80002a6c:	01013403          	ld	s0,16(sp)
    80002a70:	00813483          	ld	s1,8(sp)
    80002a74:	02010113          	addi	sp,sp,32
    80002a78:	00008067          	ret

0000000080002a7c <_ZN6Kernel17sysThreadDispatchEPNS_21ArgumentsOfSystemCallE>:
{
    80002a7c:	ff010113          	addi	sp,sp,-16
    80002a80:	00113423          	sd	ra,8(sp)
    80002a84:	00813023          	sd	s0,0(sp)
    80002a88:	01010413          	addi	s0,sp,16
    TCB::dispatch();
    80002a8c:	fffff097          	auipc	ra,0xfffff
    80002a90:	468080e7          	jalr	1128(ra) # 80001ef4 <_ZN3TCB8dispatchEv>
}
    80002a94:	00000513          	li	a0,0
    80002a98:	00813083          	ld	ra,8(sp)
    80002a9c:	00013403          	ld	s0,0(sp)
    80002aa0:	01010113          	addi	sp,sp,16
    80002aa4:	00008067          	ret

0000000080002aa8 <_ZN6Kernel21initializeSystemCallsEv>:
    KConsole::addCharToOutputBuffer(arg->a0);
    return 0;
}

void Kernel::initializeSystemCalls(void)
{
    80002aa8:	ff010113          	addi	sp,sp,-16
    80002aac:	00813423          	sd	s0,8(sp)
    80002ab0:	01010413          	addi	s0,sp,16
    systemCallsTable[KernelConfig::MEM_ALLOC] = &sysMalloc;
    80002ab4:	00005797          	auipc	a5,0x5
    80002ab8:	92c78793          	addi	a5,a5,-1748 # 800073e0 <_ZN6Kernel20queueOfAsleepThreadsE>
    80002abc:	00000717          	auipc	a4,0x0
    80002ac0:	cfc70713          	addi	a4,a4,-772 # 800027b8 <_ZN6Kernel9sysMallocEPNS_21ArgumentsOfSystemCallE>
    80002ac4:	00e7b823          	sd	a4,16(a5)
    systemCallsTable[KernelConfig::MEM_FREE] = &sysFree;
    80002ac8:	00000717          	auipc	a4,0x0
    80002acc:	d5870713          	addi	a4,a4,-680 # 80002820 <_ZN6Kernel7sysFreeEPNS_21ArgumentsOfSystemCallE>
    80002ad0:	00e7bc23          	sd	a4,24(a5)
    systemCallsTable[KernelConfig::MEM_FREE_SPACE] = &sysGetFreeSpace;
    80002ad4:	00000717          	auipc	a4,0x0
    80002ad8:	d7870713          	addi	a4,a4,-648 # 8000284c <_ZN6Kernel15sysGetFreeSpaceEPNS_21ArgumentsOfSystemCallE>
    80002adc:	02e7b023          	sd	a4,32(a5)
    systemCallsTable[KernelConfig::LARGEST_FREE_BLOCK] = &sysLargestFreeBlock;
    80002ae0:	00000717          	auipc	a4,0x0
    80002ae4:	d9470713          	addi	a4,a4,-620 # 80002874 <_ZN6Kernel19sysLargestFreeBlockEPNS_21ArgumentsOfSystemCallE>
    80002ae8:	02e7b423          	sd	a4,40(a5)
    systemCallsTable[KernelConfig::THREAD_CREATE] = &sysThreadCreate;
    80002aec:	00001717          	auipc	a4,0x1
    80002af0:	95c70713          	addi	a4,a4,-1700 # 80003448 <_ZN6Kernel15sysThreadCreateEPNS_21ArgumentsOfSystemCallE>
    80002af4:	08e7b823          	sd	a4,144(a5)
    systemCallsTable[KernelConfig::SEMAPHORE_OPEN] = &sysSemaphoreOpen;
    80002af8:	00001717          	auipc	a4,0x1
    80002afc:	9e870713          	addi	a4,a4,-1560 # 800034e0 <_ZN6Kernel16sysSemaphoreOpenEPNS_21ArgumentsOfSystemCallE>
    80002b00:	10e7b823          	sd	a4,272(a5)
    systemCallsTable[KernelConfig::SEMAPHORE_CLOSE] = &sysSemaphoreClose;
    80002b04:	00000717          	auipc	a4,0x0
    80002b08:	58070713          	addi	a4,a4,1408 # 80003084 <_ZN6Kernel17sysSemaphoreCloseEPNS_21ArgumentsOfSystemCallE>
    80002b0c:	10e7bc23          	sd	a4,280(a5)
    systemCallsTable[KernelConfig::SEMAPHORE_SIGNAL] = &sysSemaphoreSignal;
    80002b10:	00000717          	auipc	a4,0x0
    80002b14:	db870713          	addi	a4,a4,-584 # 800028c8 <_ZN6Kernel18sysSemaphoreSignalEPNS_21ArgumentsOfSystemCallE>
    80002b18:	12e7b423          	sd	a4,296(a5)
    systemCallsTable[KernelConfig::SEMAPHORE_WAIT] = &sysSemaphoreWait;
    80002b1c:	00000717          	auipc	a4,0x0
    80002b20:	d8070713          	addi	a4,a4,-640 # 8000289c <_ZN6Kernel16sysSemaphoreWaitEPNS_21ArgumentsOfSystemCallE>
    80002b24:	12e7b023          	sd	a4,288(a5)
    systemCallsTable[KernelConfig::TIME_SLEEP] = &sysTimeSleep;
    80002b28:	00000717          	auipc	a4,0x0
    80002b2c:	dcc70713          	addi	a4,a4,-564 # 800028f4 <_ZN6Kernel12sysTimeSleepEPNS_21ArgumentsOfSystemCallE>
    80002b30:	18e7b823          	sd	a4,400(a5)
    systemCallsTable[KernelConfig::GETC] = &sysGetc;
    80002b34:	00000717          	auipc	a4,0x0
    80002b38:	02470713          	addi	a4,a4,36 # 80002b58 <_ZN6Kernel7sysGetcEPNS_21ArgumentsOfSystemCallE>
    80002b3c:	20e7b823          	sd	a4,528(a5)
    systemCallsTable[KernelConfig::PUTC] = &sysPutc;
    80002b40:	00000717          	auipc	a4,0x0
    80002b44:	2cc70713          	addi	a4,a4,716 # 80002e0c <_ZN6Kernel7sysPutcEPNS_21ArgumentsOfSystemCallE>
    80002b48:	20e7bc23          	sd	a4,536(a5)
    80002b4c:	00813403          	ld	s0,8(sp)
    80002b50:	01010113          	addi	sp,sp,16
    80002b54:	00008067          	ret

0000000080002b58 <_ZN6Kernel7sysGetcEPNS_21ArgumentsOfSystemCallE>:
{
    80002b58:	fe010113          	addi	sp,sp,-32
    80002b5c:	00113c23          	sd	ra,24(sp)
    80002b60:	00813823          	sd	s0,16(sp)
    80002b64:	00913423          	sd	s1,8(sp)
    80002b68:	01213023          	sd	s2,0(sp)
    80002b6c:	02010413          	addi	s0,sp,32
    static void setConsumerThread(TCB* thread) { consumerThread = thread; }

    static TCB* getProducerThread() { return producerThread; }
    static void setProducerThread(TCB* thread) { producerThread = thread; }

    static bool isInputBufferEmpty() { return inputBuffer->isBufferEmpty(); }
    80002b70:	00004797          	auipc	a5,0x4
    80002b74:	7887b783          	ld	a5,1928(a5) # 800072f8 <_GLOBAL_OFFSET_TABLE_+0x68>
    80002b78:	0007b503          	ld	a0,0(a5)
    80002b7c:	fffff097          	auipc	ra,0xfffff
    80002b80:	f48080e7          	jalr	-184(ra) # 80001ac4 <_ZNK6BufferIcLm100EE13isBufferEmptyEv>
    if(KConsole::isInputBufferEmpty())
    80002b84:	02051263          	bnez	a0,80002ba8 <_ZN6Kernel7sysGetcEPNS_21ArgumentsOfSystemCallE+0x50>
    return (uint64)KConsole::getCharFromInputBuffer();
    80002b88:	fffff097          	auipc	ra,0xfffff
    80002b8c:	cf4080e7          	jalr	-780(ra) # 8000187c <_ZN8KConsole22getCharFromInputBufferEv>
}
    80002b90:	01813083          	ld	ra,24(sp)
    80002b94:	01013403          	ld	s0,16(sp)
    80002b98:	00813483          	ld	s1,8(sp)
    80002b9c:	00013903          	ld	s2,0(sp)
    80002ba0:	02010113          	addi	sp,sp,32
    80002ba4:	00008067          	ret
    static TCB* getRunningThread() { return running; }
    80002ba8:	00004917          	auipc	s2,0x4
    80002bac:	74893903          	ld	s2,1864(s2) # 800072f0 <_GLOBAL_OFFSET_TABLE_+0x60>
    80002bb0:	00093483          	ld	s1,0(s2)
        TCB::setRunningThread(Scheduler::get());
    80002bb4:	fffff097          	auipc	ra,0xfffff
    80002bb8:	1b0080e7          	jalr	432(ra) # 80001d64 <_ZN9Scheduler3getEv>
    static void setRunningThread(TCB* newRunningThread) { running = newRunningThread; }
    80002bbc:	00a93023          	sd	a0,0(s2)
    void resetState() {state = nullptr; }
    80002bc0:	0404b423          	sd	zero,72(s1)
        KConsole::addThreadToInputWaitQueue(oldThread);
    80002bc4:	00048513          	mv	a0,s1
    80002bc8:	fffff097          	auipc	ra,0xfffff
    80002bcc:	bcc080e7          	jalr	-1076(ra) # 80001794 <_ZN8KConsole25addThreadToInputWaitQueueEP3TCB>
    static TCB* getRunningThread() { return running; }
    80002bd0:	00093583          	ld	a1,0(s2)
        context_switch(oldThread->getContext(), TCB::getRunningThread()->getContext());
    80002bd4:	00858593          	addi	a1,a1,8
    80002bd8:	00848513          	addi	a0,s1,8
    80002bdc:	ffffe097          	auipc	ra,0xffffe
    80002be0:	5c4080e7          	jalr	1476(ra) # 800011a0 <context_switch>
    80002be4:	fa5ff06f          	j	80002b88 <_ZN6Kernel7sysGetcEPNS_21ArgumentsOfSystemCallE+0x30>

0000000080002be8 <_ZN6Kernel16interruptHandlerEv>:
{
    80002be8:	f9010113          	addi	sp,sp,-112
    80002bec:	06113423          	sd	ra,104(sp)
    80002bf0:	06813023          	sd	s0,96(sp)
    80002bf4:	04913c23          	sd	s1,88(sp)
    80002bf8:	05213823          	sd	s2,80(sp)
    80002bfc:	05313423          	sd	s3,72(sp)
    80002c00:	05413023          	sd	s4,64(sp)
    80002c04:	07010413          	addi	s0,sp,112
    __asm__ volatile ("addi %[reg], s0, 0x0": [reg]"=r"(basePointer)); // Problem: da li mozemo biti 100% sigurni da ce s0 biti nepromenjen; resenje inline f-ja
    80002c08:	00040793          	mv	a5,s0
    80002c0c:	fcf43423          	sd	a5,-56(s0)
    __asm__ volatile ("csrr %[cause], scause": [cause] "=r"(scause));
    80002c10:	142027f3          	csrr	a5,scause
    switch (scause)
    80002c14:	fff00713          	li	a4,-1
    80002c18:	03f71713          	slli	a4,a4,0x3f
    80002c1c:	00170713          	addi	a4,a4,1
    80002c20:	12e78463          	beq	a5,a4,80002d48 <_ZN6Kernel16interruptHandlerEv+0x160>
    80002c24:	fff00713          	li	a4,-1
    80002c28:	03f71713          	slli	a4,a4,0x3f
    80002c2c:	00170713          	addi	a4,a4,1
    80002c30:	08f76a63          	bltu	a4,a5,80002cc4 <_ZN6Kernel16interruptHandlerEv+0xdc>
    80002c34:	ff878793          	addi	a5,a5,-8
    80002c38:	00100713          	li	a4,1
    80002c3c:	06f76463          	bltu	a4,a5,80002ca4 <_ZN6Kernel16interruptHandlerEv+0xbc>
    __asm__ volatile ("csrc sip, %[reg]":: [reg] "r"(mask));
    80002c40:	00200793          	li	a5,2
    80002c44:	1447b073          	csrc	sip,a5
}
inline uint64 Machine::readSepc()
{
    uint64 returnAddress;
    __asm__ volatile ("csrr %[reg], sepc": [reg] "=r"(returnAddress));
    80002c48:	141029f3          	csrr	s3,sepc
            uint64 sepc = Machine::readSepc() + 4;
    80002c4c:	00498993          	addi	s3,s3,4
    __asm__ volatile("csrw sstatus, %[reg]":: [reg] "r"(oldStatus));
}
inline uint64 Machine::readSstatus()
{
    uint64 returnStatus;
    __asm__ volatile ("csrr %[reg], sstatus": [reg] "=r"(returnStatus));
    80002c50:	10002a73          	csrr	s4,sstatus
            __asm__ volatile ("ld %[rd], 80(%[rs])": [rd]"=r"(numberOfEntry):[rs]"r"(basePointer));
    80002c54:	fc843483          	ld	s1,-56(s0)
    80002c58:	0504b483          	ld	s1,80(s1)
            initializeArguments(&arg, basePointer);
    80002c5c:	fc843583          	ld	a1,-56(s0)
    80002c60:	f9040913          	addi	s2,s0,-112
    80002c64:	00090513          	mv	a0,s2
    80002c68:	00000097          	auipc	ra,0x0
    80002c6c:	d08080e7          	jalr	-760(ra) # 80002970 <_ZN6Kernel19initializeArgumentsEPNS_21ArgumentsOfSystemCallEm>
            systemCallsTable[numberOfEntry](&arg);
    80002c70:	00349493          	slli	s1,s1,0x3
    80002c74:	00004797          	auipc	a5,0x4
    80002c78:	76c78793          	addi	a5,a5,1900 # 800073e0 <_ZN6Kernel20queueOfAsleepThreadsE>
    80002c7c:	009784b3          	add	s1,a5,s1
    80002c80:	0084b783          	ld	a5,8(s1)
    80002c84:	00090513          	mv	a0,s2
    80002c88:	000780e7          	jalr	a5
            __asm__ volatile("sd a0, 80(%[rs])"::[rs]"r"(basePointer));
    80002c8c:	fc843783          	ld	a5,-56(s0)
    80002c90:	04a7b823          	sd	a0,80(a5)
            TCB::dispatch();
    80002c94:	fffff097          	auipc	ra,0xfffff
    80002c98:	260080e7          	jalr	608(ra) # 80001ef4 <_ZN3TCB8dispatchEv>
    __asm__ volatile("csrw sepc, %[reg]":: [reg] "r"(address));
    80002c9c:	14199073          	csrw	sepc,s3
    __asm__ volatile("csrw sstatus, %[reg]":: [reg] "r"(oldStatus));
    80002ca0:	100a1073          	csrw	sstatus,s4
}
    80002ca4:	06813083          	ld	ra,104(sp)
    80002ca8:	06013403          	ld	s0,96(sp)
    80002cac:	05813483          	ld	s1,88(sp)
    80002cb0:	05013903          	ld	s2,80(sp)
    80002cb4:	04813983          	ld	s3,72(sp)
    80002cb8:	04013a03          	ld	s4,64(sp)
    80002cbc:	07010113          	addi	sp,sp,112
    80002cc0:	00008067          	ret
    switch (scause)
    80002cc4:	fff00713          	li	a4,-1
    80002cc8:	03f71713          	slli	a4,a4,0x3f
    80002ccc:	00970713          	addi	a4,a4,9
    80002cd0:	fce79ae3          	bne	a5,a4,80002ca4 <_ZN6Kernel16interruptHandlerEv+0xbc>
    __asm__ volatile ("csrc sip, %[reg]":: [reg] "r"(mask));
    80002cd4:	20000793          	li	a5,512
    80002cd8:	1447b073          	csrc	sip,a5
    __asm__ volatile ("csrr %[reg], sepc": [reg] "=r"(returnAddress));
    80002cdc:	141024f3          	csrr	s1,sepc
            uint64 sepc = Machine::readSepc() + 4;
    80002ce0:	00448493          	addi	s1,s1,4
    __asm__ volatile ("csrr %[reg], sstatus": [reg] "=r"(returnStatus));
    80002ce4:	100029f3          	csrr	s3,sstatus
            int numOfDevice = plic_claim();
    80002ce8:	00001097          	auipc	ra,0x1
    80002cec:	3ec080e7          	jalr	1004(ra) # 800040d4 <plic_claim>
    80002cf0:	00050913          	mv	s2,a0
            __asm__ volatile("lb %[status], 0(%[address])": [status] "=r"(statusReg): [address] "r"(CONSOLE_STATUS));
    80002cf4:	00004797          	auipc	a5,0x4
    80002cf8:	5ac7b783          	ld	a5,1452(a5) # 800072a0 <_GLOBAL_OFFSET_TABLE_+0x10>
    80002cfc:	0007b783          	ld	a5,0(a5)
    80002d00:	00078783          	lb	a5,0(a5)
    80002d04:	0ff7f793          	andi	a5,a5,255
            if (statusReg & CONSOLE_TX_STATUS_BIT) {
    80002d08:	0207f793          	andi	a5,a5,32
    80002d0c:	0c078063          	beqz	a5,80002dcc <_ZN6Kernel16interruptHandlerEv+0x1e4>
    static bool isInputBufferFull() { return inputBuffer->isBufferFull(); }

    static bool isOutputBufferFull() { return outputBuffer->isBufferFull(); }
    static bool isOutputBufferEmpty() { return outputBuffer->isBufferEmpty(); }
    80002d10:	00004797          	auipc	a5,0x4
    80002d14:	5c07b783          	ld	a5,1472(a5) # 800072d0 <_GLOBAL_OFFSET_TABLE_+0x40>
    80002d18:	0007b503          	ld	a0,0(a5)
    80002d1c:	fffff097          	auipc	ra,0xfffff
    80002d20:	da8080e7          	jalr	-600(ra) # 80001ac4 <_ZNK6BufferIcLm100EE13isBufferEmptyEv>
                if (KConsole::isOutputBufferEmpty()) {
    80002d24:	08050863          	beqz	a0,80002db4 <_ZN6Kernel16interruptHandlerEv+0x1cc>
                    plic_complete(numOfDevice);
    80002d28:	00090513          	mv	a0,s2
    80002d2c:	00001097          	auipc	ra,0x1
    80002d30:	3e0080e7          	jalr	992(ra) # 8000410c <plic_complete>
            TCB::dispatch();
    80002d34:	fffff097          	auipc	ra,0xfffff
    80002d38:	1c0080e7          	jalr	448(ra) # 80001ef4 <_ZN3TCB8dispatchEv>
    __asm__ volatile("csrw sepc, %[reg]":: [reg] "r"(address));
    80002d3c:	14149073          	csrw	sepc,s1
    __asm__ volatile("csrw sstatus, %[reg]":: [reg] "r"(oldStatus));
    80002d40:	10099073          	csrw	sstatus,s3
}
    80002d44:	f61ff06f          	j	80002ca4 <_ZN6Kernel16interruptHandlerEv+0xbc>
    __asm__ volatile ("csrc sip, %[reg]":: [reg] "r"(mask));
    80002d48:	00200793          	li	a5,2
    80002d4c:	1447b073          	csrc	sip,a5

    static size_t getNumOfTicks() { return numOfTicks; }
    static void resetNumOfTicks() { numOfTicks = DEFAULT_TIME_SLICE; }
    static void incrementNumOfTicks() { numOfTicks++; }
    80002d50:	00004717          	auipc	a4,0x4
    80002d54:	58873703          	ld	a4,1416(a4) # 800072d8 <_GLOBAL_OFFSET_TABLE_+0x48>
    80002d58:	00073783          	ld	a5,0(a4)
    80002d5c:	00178793          	addi	a5,a5,1
    80002d60:	00f73023          	sd	a5,0(a4)
    static TCB* getRunningThread() { return running; }
    80002d64:	00004717          	auipc	a4,0x4
    80002d68:	58c73703          	ld	a4,1420(a4) # 800072f0 <_GLOBAL_OFFSET_TABLE_+0x60>
    80002d6c:	00073703          	ld	a4,0(a4)
    size_t getTimeSlice() const { return timeSlice; }
    80002d70:	03073703          	ld	a4,48(a4)
            if (TCB::getNumOfTicks() >= TCB::getRunningThread()->getTimeSlice()) {
    80002d74:	00e7f863          	bgeu	a5,a4,80002d84 <_ZN6Kernel16interruptHandlerEv+0x19c>
            wakeUpThreads();
    80002d78:	00000097          	auipc	ra,0x0
    80002d7c:	c88080e7          	jalr	-888(ra) # 80002a00 <_ZN6Kernel13wakeUpThreadsEv>
            break;
    80002d80:	f25ff06f          	j	80002ca4 <_ZN6Kernel16interruptHandlerEv+0xbc>
    static void resetNumOfTicks() { numOfTicks = DEFAULT_TIME_SLICE; }
    80002d84:	00004797          	auipc	a5,0x4
    80002d88:	5547b783          	ld	a5,1364(a5) # 800072d8 <_GLOBAL_OFFSET_TABLE_+0x48>
    80002d8c:	00200713          	li	a4,2
    80002d90:	00e7b023          	sd	a4,0(a5)
    __asm__ volatile ("csrr %[reg], sepc": [reg] "=r"(returnAddress));
    80002d94:	141024f3          	csrr	s1,sepc
                uint64 sepc = Machine::readSepc() + 4;
    80002d98:	00448493          	addi	s1,s1,4
    __asm__ volatile ("csrr %[reg], sstatus": [reg] "=r"(returnStatus));
    80002d9c:	10002973          	csrr	s2,sstatus
                TCB::dispatch();
    80002da0:	fffff097          	auipc	ra,0xfffff
    80002da4:	154080e7          	jalr	340(ra) # 80001ef4 <_ZN3TCB8dispatchEv>
    __asm__ volatile("csrw sepc, %[reg]":: [reg] "r"(address));
    80002da8:	14149073          	csrw	sepc,s1
    __asm__ volatile("csrw sstatus, %[reg]":: [reg] "r"(oldStatus));
    80002dac:	10091073          	csrw	sstatus,s2
}
    80002db0:	fc9ff06f          	j	80002d78 <_ZN6Kernel16interruptHandlerEv+0x190>
                    Scheduler::put(KConsole::getConsumerThread());
    80002db4:	00004797          	auipc	a5,0x4
    80002db8:	52c7b783          	ld	a5,1324(a5) # 800072e0 <_GLOBAL_OFFSET_TABLE_+0x50>
    80002dbc:	0007b503          	ld	a0,0(a5)
    80002dc0:	fffff097          	auipc	ra,0xfffff
    80002dc4:	f70080e7          	jalr	-144(ra) # 80001d30 <_ZN9Scheduler3putEP3TCB>
    80002dc8:	f6dff06f          	j	80002d34 <_ZN6Kernel16interruptHandlerEv+0x14c>
    static bool isInputBufferFull() { return inputBuffer->isBufferFull(); }
    80002dcc:	00004797          	auipc	a5,0x4
    80002dd0:	52c7b783          	ld	a5,1324(a5) # 800072f8 <_GLOBAL_OFFSET_TABLE_+0x68>
    80002dd4:	0007b503          	ld	a0,0(a5)
    80002dd8:	fffff097          	auipc	ra,0xfffff
    80002ddc:	d0c080e7          	jalr	-756(ra) # 80001ae4 <_ZNK6BufferIcLm100EE12isBufferFullEv>
                if (KConsole::isInputBufferFull()) {
    80002de0:	00050a63          	beqz	a0,80002df4 <_ZN6Kernel16interruptHandlerEv+0x20c>
                    plic_complete(numOfDevice);
    80002de4:	00090513          	mv	a0,s2
    80002de8:	00001097          	auipc	ra,0x1
    80002dec:	324080e7          	jalr	804(ra) # 8000410c <plic_complete>
    80002df0:	f45ff06f          	j	80002d34 <_ZN6Kernel16interruptHandlerEv+0x14c>
                    Scheduler::put(KConsole::getProducerThread());
    80002df4:	00004797          	auipc	a5,0x4
    80002df8:	51c7b783          	ld	a5,1308(a5) # 80007310 <_GLOBAL_OFFSET_TABLE_+0x80>
    80002dfc:	0007b503          	ld	a0,0(a5)
    80002e00:	fffff097          	auipc	ra,0xfffff
    80002e04:	f30080e7          	jalr	-208(ra) # 80001d30 <_ZN9Scheduler3putEP3TCB>
    80002e08:	f2dff06f          	j	80002d34 <_ZN6Kernel16interruptHandlerEv+0x14c>

0000000080002e0c <_ZN6Kernel7sysPutcEPNS_21ArgumentsOfSystemCallE>:
{
    80002e0c:	fd010113          	addi	sp,sp,-48
    80002e10:	02113423          	sd	ra,40(sp)
    80002e14:	02813023          	sd	s0,32(sp)
    80002e18:	00913c23          	sd	s1,24(sp)
    80002e1c:	01213823          	sd	s2,16(sp)
    80002e20:	01313423          	sd	s3,8(sp)
    80002e24:	03010413          	addi	s0,sp,48
    80002e28:	00050493          	mv	s1,a0
    static bool isOutputBufferFull() { return outputBuffer->isBufferFull(); }
    80002e2c:	00004797          	auipc	a5,0x4
    80002e30:	4a47b783          	ld	a5,1188(a5) # 800072d0 <_GLOBAL_OFFSET_TABLE_+0x40>
    80002e34:	0007b503          	ld	a0,0(a5)
    80002e38:	fffff097          	auipc	ra,0xfffff
    80002e3c:	cac080e7          	jalr	-852(ra) # 80001ae4 <_ZNK6BufferIcLm100EE12isBufferFullEv>
    if(KConsole::isOutputBufferFull())
    80002e40:	02051863          	bnez	a0,80002e70 <_ZN6Kernel7sysPutcEPNS_21ArgumentsOfSystemCallE+0x64>
    KConsole::addCharToOutputBuffer(arg->a0);
    80002e44:	0004c503          	lbu	a0,0(s1)
    80002e48:	fffff097          	auipc	ra,0xfffff
    80002e4c:	b3c080e7          	jalr	-1220(ra) # 80001984 <_ZN8KConsole21addCharToOutputBufferEc>
}
    80002e50:	00000513          	li	a0,0
    80002e54:	02813083          	ld	ra,40(sp)
    80002e58:	02013403          	ld	s0,32(sp)
    80002e5c:	01813483          	ld	s1,24(sp)
    80002e60:	01013903          	ld	s2,16(sp)
    80002e64:	00813983          	ld	s3,8(sp)
    80002e68:	03010113          	addi	sp,sp,48
    80002e6c:	00008067          	ret
    static TCB* getRunningThread() { return running; }
    80002e70:	00004997          	auipc	s3,0x4
    80002e74:	4809b983          	ld	s3,1152(s3) # 800072f0 <_GLOBAL_OFFSET_TABLE_+0x60>
    80002e78:	0009b903          	ld	s2,0(s3)
        TCB::setRunningThread(Scheduler::get());
    80002e7c:	fffff097          	auipc	ra,0xfffff
    80002e80:	ee8080e7          	jalr	-280(ra) # 80001d64 <_ZN9Scheduler3getEv>
    static void setRunningThread(TCB* newRunningThread) { running = newRunningThread; }
    80002e84:	00a9b023          	sd	a0,0(s3)
    void resetState() {state = nullptr; }
    80002e88:	04093423          	sd	zero,72(s2)
        KConsole::addThreadToOutputWaitQueue(oldThread);
    80002e8c:	00090513          	mv	a0,s2
    80002e90:	fffff097          	auipc	ra,0xfffff
    80002e94:	938080e7          	jalr	-1736(ra) # 800017c8 <_ZN8KConsole26addThreadToOutputWaitQueueEP3TCB>
    static TCB* getRunningThread() { return running; }
    80002e98:	0009b583          	ld	a1,0(s3)
        context_switch(oldThread->getContext(), TCB::getRunningThread()->getContext());
    80002e9c:	00858593          	addi	a1,a1,8
    80002ea0:	00890513          	addi	a0,s2,8
    80002ea4:	ffffe097          	auipc	ra,0xffffe
    80002ea8:	2fc080e7          	jalr	764(ra) # 800011a0 <context_switch>
    80002eac:	f99ff06f          	j	80002e44 <_ZN6Kernel7sysPutcEPNS_21ArgumentsOfSystemCallE+0x38>

0000000080002eb0 <_Z41__static_initialization_and_destruction_0ii>:
    80002eb0:	00100793          	li	a5,1
    80002eb4:	00f50463          	beq	a0,a5,80002ebc <_Z41__static_initialization_and_destruction_0ii+0xc>
    80002eb8:	00008067          	ret
    80002ebc:	000107b7          	lui	a5,0x10
    80002ec0:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80002ec4:	fef59ae3          	bne	a1,a5,80002eb8 <_Z41__static_initialization_and_destruction_0ii+0x8>
    80002ec8:	fe010113          	addi	sp,sp,-32
    80002ecc:	00113c23          	sd	ra,24(sp)
    80002ed0:	00813823          	sd	s0,16(sp)
    80002ed4:	00913423          	sd	s1,8(sp)
    80002ed8:	02010413          	addi	s0,sp,32
ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>* Kernel::poolOfThreads = new ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>();
    80002edc:	000014b7          	lui	s1,0x1
    80002ee0:	8d848513          	addi	a0,s1,-1832 # 8d8 <_entry-0x7ffff728>
    80002ee4:	00000097          	auipc	ra,0x0
    80002ee8:	698080e7          	jalr	1688(ra) # 8000357c <_ZN10ObjectPoolI3TCBLm20EEnwEm>


template <typename T, size_t numOfObjects>
class ObjectPool {
public:
    ObjectPool(): headFreeObject(pool), nextObjectPool(nullptr), prevObjectPool(nullptr)
    80002eec:	009507b3          	add	a5,a0,s1
    80002ef0:	8ca7b023          	sd	a0,-1856(a5)
    80002ef4:	8c07b423          	sd	zero,-1848(a5)
    80002ef8:	8c07b823          	sd	zero,-1840(a5)
    {

        for(size_t i = 0; i < numOfObjects - 1; i++)
    80002efc:	00000693          	li	a3,0
    80002f00:	01200793          	li	a5,18
    80002f04:	02d7ea63          	bltu	a5,a3,80002f38 <_Z41__static_initialization_and_destruction_0ii+0x88>
        {
            pool[i].nextFree = &(pool[i+1]);
    80002f08:	00168613          	addi	a2,a3,1
    80002f0c:	00361713          	slli	a4,a2,0x3
    80002f10:	40c70733          	sub	a4,a4,a2
    80002f14:	00471713          	slli	a4,a4,0x4
    80002f18:	00e50733          	add	a4,a0,a4
    80002f1c:	00369793          	slli	a5,a3,0x3
    80002f20:	40d787b3          	sub	a5,a5,a3
    80002f24:	00479793          	slli	a5,a5,0x4
    80002f28:	00f507b3          	add	a5,a0,a5
    80002f2c:	06e7b423          	sd	a4,104(a5)
        for(size_t i = 0; i < numOfObjects - 1; i++)
    80002f30:	00060693          	mv	a3,a2
    80002f34:	fcdff06f          	j	80002f00 <_Z41__static_initialization_and_destruction_0ii+0x50>
        }
        pool[numOfObjects - 1].nextFree = nullptr;
    80002f38:	000017b7          	lui	a5,0x1
    80002f3c:	00f507b3          	add	a5,a0,a5
    80002f40:	8a07bc23          	sd	zero,-1864(a5) # 8b8 <_entry-0x7ffff748>
    80002f44:	00004797          	auipc	a5,0x4
    80002f48:	6aa7be23          	sd	a0,1724(a5) # 80007600 <_ZN6Kernel13poolOfThreadsE>
ObjectPool<KSemaphore, KernelConfig::NUM_OF_SEMAPHORES_IN_POOL>* Kernel::poolOfSemaphores = new ObjectPool<KSemaphore, KernelConfig::NUM_OF_SEMAPHORES_IN_POOL>();
    80002f4c:	15800513          	li	a0,344
    80002f50:	00000097          	auipc	ra,0x0
    80002f54:	668080e7          	jalr	1640(ra) # 800035b8 <_ZN10ObjectPoolI10KSemaphoreLm10EEnwEm>
    ObjectPool(): headFreeObject(pool), nextObjectPool(nullptr), prevObjectPool(nullptr)
    80002f58:	14a53023          	sd	a0,320(a0)
    80002f5c:	14053423          	sd	zero,328(a0)
    80002f60:	14053823          	sd	zero,336(a0)
        for(size_t i = 0; i < numOfObjects - 1; i++)
    80002f64:	00000793          	li	a5,0
    80002f68:	00800713          	li	a4,8
    80002f6c:	02f76263          	bltu	a4,a5,80002f90 <_Z41__static_initialization_and_destruction_0ii+0xe0>
            pool[i].nextFree = &(pool[i+1]);
    80002f70:	00178693          	addi	a3,a5,1
    80002f74:	00569713          	slli	a4,a3,0x5
    80002f78:	00e50733          	add	a4,a0,a4
    80002f7c:	00579793          	slli	a5,a5,0x5
    80002f80:	00f507b3          	add	a5,a0,a5
    80002f84:	00e7bc23          	sd	a4,24(a5)
        for(size_t i = 0; i < numOfObjects - 1; i++)
    80002f88:	00068793          	mv	a5,a3
    80002f8c:	fddff06f          	j	80002f68 <_Z41__static_initialization_and_destruction_0ii+0xb8>
        pool[numOfObjects - 1].nextFree = nullptr;
    80002f90:	12053c23          	sd	zero,312(a0)
    80002f94:	00004497          	auipc	s1,0x4
    80002f98:	44c48493          	addi	s1,s1,1100 # 800073e0 <_ZN6Kernel20queueOfAsleepThreadsE>
    80002f9c:	22a4b423          	sd	a0,552(s1)
PriorityQueue<TCB, decltype(cmp)>* Kernel::queueOfAsleepThreads = new PriorityQueue<TCB, decltype(cmp)>(cmp);
    80002fa0:	01800513          	li	a0,24
    80002fa4:	00000097          	auipc	ra,0x0
    80002fa8:	840080e7          	jalr	-1984(ra) # 800027e4 <_ZN13PriorityQueueI3TCBUlPS0_S1_E_EnwEm>
    explicit PriorityQueue(Compare c) : cmp(c) {}
    80002fac:	00053023          	sd	zero,0(a0)
    80002fb0:	00053423          	sd	zero,8(a0)
    80002fb4:	00a4b023          	sd	a0,0(s1)
    80002fb8:	01813083          	ld	ra,24(sp)
    80002fbc:	01013403          	ld	s0,16(sp)
    80002fc0:	00813483          	ld	s1,8(sp)
    80002fc4:	02010113          	addi	sp,sp,32
    80002fc8:	00008067          	ret

0000000080002fcc <_ZN6Kernel13sysThreadExitEPNS_21ArgumentsOfSystemCallE>:
{
    80002fcc:	ff010113          	addi	sp,sp,-16
    80002fd0:	00113423          	sd	ra,8(sp)
    80002fd4:	00813023          	sd	s0,0(sp)
    80002fd8:	01010413          	addi	s0,sp,16
    80002fdc:	00004797          	auipc	a5,0x4
    80002fe0:	3147b783          	ld	a5,788(a5) # 800072f0 <_GLOBAL_OFFSET_TABLE_+0x60>
    80002fe4:	0007b783          	ld	a5,0(a5)
    if(MemoryAllocator::freeMemory(TCB::getRunningThread()->getSystemStack()) == -1)
    80002fe8:	0287b503          	ld	a0,40(a5)
    80002fec:	fffff097          	auipc	ra,0xfffff
    80002ff0:	274080e7          	jalr	628(ra) # 80002260 <_ZN15MemoryAllocator10freeMemoryEPv>
    80002ff4:	fff00793          	li	a5,-1
    80002ff8:	06f50e63          	beq	a0,a5,80003074 <_ZN6Kernel13sysThreadExitEPNS_21ArgumentsOfSystemCallE+0xa8>
    80002ffc:	00004797          	auipc	a5,0x4
    80003000:	2f47b783          	ld	a5,756(a5) # 800072f0 <_GLOBAL_OFFSET_TABLE_+0x60>
    80003004:	0007b783          	ld	a5,0(a5)
    void setIsFinished() { finished = true; }
    80003008:	00100713          	li	a4,1
    8000300c:	04e78823          	sb	a4,80(a5)
    if(MemoryAllocator::freeMemory(TCB::getRunningThread()->getUserStack()) == -1)
    80003010:	0207b503          	ld	a0,32(a5)
    80003014:	fffff097          	auipc	ra,0xfffff
    80003018:	24c080e7          	jalr	588(ra) # 80002260 <_ZN15MemoryAllocator10freeMemoryEPv>
    8000301c:	fff00793          	li	a5,-1
    80003020:	04f50e63          	beq	a0,a5,8000307c <_ZN6Kernel13sysThreadExitEPNS_21ArgumentsOfSystemCallE+0xb0>
    static TCB* getRunningThread() { return running; }
    80003024:	00004797          	auipc	a5,0x4
    80003028:	2cc7b783          	ld	a5,716(a5) # 800072f0 <_GLOBAL_OFFSET_TABLE_+0x60>
    8000302c:	0007b583          	ld	a1,0(a5)
    KSemaphore* getSemaphoreOnWait() const { return waitOnSemaphore; }
    80003030:	0405b503          	ld	a0,64(a1)
    if(!TCB::getRunningThread()->getSemaphoreOnWait())
    80003034:	02050a63          	beqz	a0,80003068 <_ZN6Kernel13sysThreadExitEPNS_21ArgumentsOfSystemCallE+0x9c>
    Kernel::poolOfThreads->freeObject(TCB::getRunningThread());
    80003038:	00004797          	auipc	a5,0x4
    8000303c:	2b87b783          	ld	a5,696(a5) # 800072f0 <_GLOBAL_OFFSET_TABLE_+0x60>
    80003040:	0007b583          	ld	a1,0(a5)
    80003044:	00004517          	auipc	a0,0x4
    80003048:	5bc53503          	ld	a0,1468(a0) # 80007600 <_ZN6Kernel13poolOfThreadsE>
    8000304c:	00000097          	auipc	ra,0x0
    80003050:	5a8080e7          	jalr	1448(ra) # 800035f4 <_ZN10ObjectPoolI3TCBLm20EE10freeObjectEPS0_>
    return 0;
    80003054:	00000513          	li	a0,0
}
    80003058:	00813083          	ld	ra,8(sp)
    8000305c:	00013403          	ld	s0,0(sp)
    80003060:	01010113          	addi	sp,sp,16
    80003064:	00008067          	ret
        tempSemaphore->removeThreadFromBlockedQueue(TCB::getRunningThread());
    80003068:	fffff097          	auipc	ra,0xfffff
    8000306c:	5b8080e7          	jalr	1464(ra) # 80002620 <_ZN10KSemaphore28removeThreadFromBlockedQueueEP3TCB>
    80003070:	fc9ff06f          	j	80003038 <_ZN6Kernel13sysThreadExitEPNS_21ArgumentsOfSystemCallE+0x6c>
        return -1;
    80003074:	fff00513          	li	a0,-1
    80003078:	fe1ff06f          	j	80003058 <_ZN6Kernel13sysThreadExitEPNS_21ArgumentsOfSystemCallE+0x8c>
        return -1;
    8000307c:	fff00513          	li	a0,-1
    80003080:	fd9ff06f          	j	80003058 <_ZN6Kernel13sysThreadExitEPNS_21ArgumentsOfSystemCallE+0x8c>

0000000080003084 <_ZN6Kernel17sysSemaphoreCloseEPNS_21ArgumentsOfSystemCallE>:
{
    80003084:	fe010113          	addi	sp,sp,-32
    80003088:	00113c23          	sd	ra,24(sp)
    8000308c:	00813823          	sd	s0,16(sp)
    80003090:	00913423          	sd	s1,8(sp)
    80003094:	01213023          	sd	s2,0(sp)
    80003098:	02010413          	addi	s0,sp,32
    KSemaphore* tempSemaphore = (KSemaphore*)(arg->a0);
    8000309c:	00053903          	ld	s2,0(a0)
    returnValue = (uint64)tempSemaphore->close();
    800030a0:	00090513          	mv	a0,s2
    800030a4:	fffff097          	auipc	ra,0xfffff
    800030a8:	514080e7          	jalr	1300(ra) # 800025b8 <_ZN10KSemaphore5closeEv>
    800030ac:	00050493          	mv	s1,a0
    Kernel::poolOfSemaphores->freeObject(tempSemaphore);
    800030b0:	00090593          	mv	a1,s2
    800030b4:	00004517          	auipc	a0,0x4
    800030b8:	55453503          	ld	a0,1364(a0) # 80007608 <_ZN6Kernel16poolOfSemaphoresE>
    800030bc:	00000097          	auipc	ra,0x0
    800030c0:	56c080e7          	jalr	1388(ra) # 80003628 <_ZN10ObjectPoolI10KSemaphoreLm10EE10freeObjectEPS0_>
}
    800030c4:	00048513          	mv	a0,s1
    800030c8:	01813083          	ld	ra,24(sp)
    800030cc:	01013403          	ld	s0,16(sp)
    800030d0:	00813483          	ld	s1,8(sp)
    800030d4:	00013903          	ld	s2,0(sp)
    800030d8:	02010113          	addi	sp,sp,32
    800030dc:	00008067          	ret

00000000800030e0 <_ZN6Kernel18makeConsumerThreadEv>:
{
    800030e0:	fd010113          	addi	sp,sp,-48
    800030e4:	02113423          	sd	ra,40(sp)
    800030e8:	02813023          	sd	s0,32(sp)
    800030ec:	00913c23          	sd	s1,24(sp)
    800030f0:	01213823          	sd	s2,16(sp)
    800030f4:	03010413          	addi	s0,sp,48
    void* kernelSystemStack = Kernel::mallocSystemStack(KernelConfig::DEFAULT_SYSTEM_STACK_SIZE);
    800030f8:	40000513          	li	a0,1024
    800030fc:	00000097          	auipc	ra,0x0
    80003100:	8c4080e7          	jalr	-1852(ra) # 800029c0 <_ZN6Kernel17mallocSystemStackEm>
    80003104:	00050913          	mv	s2,a0
    TCB* consumerThread = poolOfThreads->mallocObject(&sourcePool);
    80003108:	fd840593          	addi	a1,s0,-40
    8000310c:	00004517          	auipc	a0,0x4
    80003110:	4f453503          	ld	a0,1268(a0) # 80007600 <_ZN6Kernel13poolOfThreadsE>
    80003114:	00000097          	auipc	ra,0x0
    80003118:	57c080e7          	jalr	1404(ra) # 80003690 <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEPPS1_>
    8000311c:	00050493          	mv	s1,a0
    while(!consumerThread)
    80003120:	02049063          	bnez	s1,80003140 <_ZN6Kernel18makeConsumerThreadEv+0x60>
        consumerThread = poolOfThreads->mallocObject(&sourcePool);
    80003124:	fd840593          	addi	a1,s0,-40
    80003128:	00004517          	auipc	a0,0x4
    8000312c:	4d853503          	ld	a0,1240(a0) # 80007600 <_ZN6Kernel13poolOfThreadsE>
    80003130:	00000097          	auipc	ra,0x0
    80003134:	560080e7          	jalr	1376(ra) # 80003690 <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEPPS1_>
    80003138:	00050493          	mv	s1,a0
    8000313c:	fe5ff06f          	j	80003120 <_ZN6Kernel18makeConsumerThreadEv+0x40>
    consumerThread->initializeThread(&KConsole::consumeOutputBuffer, nullptr, kernelSystemStack, kernelSystemStack, sourcePool, KernelConfig::KERNEL_MODE, KernelConfig::BLOCKED);
    80003140:	00100893          	li	a7,1
    80003144:	00100813          	li	a6,1
    80003148:	fd843783          	ld	a5,-40(s0)
    8000314c:	00090713          	mv	a4,s2
    80003150:	00090693          	mv	a3,s2
    80003154:	00000613          	li	a2,0
    80003158:	00004597          	auipc	a1,0x4
    8000315c:	1585b583          	ld	a1,344(a1) # 800072b0 <_GLOBAL_OFFSET_TABLE_+0x20>
    80003160:	00048513          	mv	a0,s1
    80003164:	fffff097          	auipc	ra,0xfffff
    80003168:	cd0080e7          	jalr	-816(ra) # 80001e34 <_ZN3TCB16initializeThreadEPFvPvES0_S0_S0_P10ObjectPoolIS_Lm20EEN12KernelConfig4ModeENS6_11ThreadStateE>
    static void setConsumerThread(TCB* thread) { consumerThread = thread; }
    8000316c:	00004797          	auipc	a5,0x4
    80003170:	1747b783          	ld	a5,372(a5) # 800072e0 <_GLOBAL_OFFSET_TABLE_+0x50>
    80003174:	0097b023          	sd	s1,0(a5)
}
    80003178:	02813083          	ld	ra,40(sp)
    8000317c:	02013403          	ld	s0,32(sp)
    80003180:	01813483          	ld	s1,24(sp)
    80003184:	01013903          	ld	s2,16(sp)
    80003188:	03010113          	addi	sp,sp,48
    8000318c:	00008067          	ret

0000000080003190 <_ZN6Kernel18makeProducerThreadEv>:
{
    80003190:	fd010113          	addi	sp,sp,-48
    80003194:	02113423          	sd	ra,40(sp)
    80003198:	02813023          	sd	s0,32(sp)
    8000319c:	00913c23          	sd	s1,24(sp)
    800031a0:	01213823          	sd	s2,16(sp)
    800031a4:	03010413          	addi	s0,sp,48
    void* kernelSystemStack = Kernel::mallocSystemStack(KernelConfig::DEFAULT_SYSTEM_STACK_SIZE);
    800031a8:	40000513          	li	a0,1024
    800031ac:	00000097          	auipc	ra,0x0
    800031b0:	814080e7          	jalr	-2028(ra) # 800029c0 <_ZN6Kernel17mallocSystemStackEm>
    800031b4:	00050913          	mv	s2,a0
    TCB* producerThread = poolOfThreads->mallocObject(&sourcePool);
    800031b8:	fd840593          	addi	a1,s0,-40
    800031bc:	00004517          	auipc	a0,0x4
    800031c0:	44453503          	ld	a0,1092(a0) # 80007600 <_ZN6Kernel13poolOfThreadsE>
    800031c4:	00000097          	auipc	ra,0x0
    800031c8:	4cc080e7          	jalr	1228(ra) # 80003690 <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEPPS1_>
    800031cc:	00050493          	mv	s1,a0
    while(!producerThread)
    800031d0:	02049063          	bnez	s1,800031f0 <_ZN6Kernel18makeProducerThreadEv+0x60>
        producerThread = poolOfThreads->mallocObject(&sourcePool);
    800031d4:	fd840593          	addi	a1,s0,-40
    800031d8:	00004517          	auipc	a0,0x4
    800031dc:	42853503          	ld	a0,1064(a0) # 80007600 <_ZN6Kernel13poolOfThreadsE>
    800031e0:	00000097          	auipc	ra,0x0
    800031e4:	4b0080e7          	jalr	1200(ra) # 80003690 <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEPPS1_>
    800031e8:	00050493          	mv	s1,a0
    800031ec:	fe5ff06f          	j	800031d0 <_ZN6Kernel18makeProducerThreadEv+0x40>
    producerThread->initializeThread(&KConsole::produceInputBuffer, nullptr, kernelSystemStack, kernelSystemStack, sourcePool, KernelConfig::KERNEL_MODE, KernelConfig::BLOCKED);
    800031f0:	00100893          	li	a7,1
    800031f4:	00100813          	li	a6,1
    800031f8:	fd843783          	ld	a5,-40(s0)
    800031fc:	00090713          	mv	a4,s2
    80003200:	00090693          	mv	a3,s2
    80003204:	00000613          	li	a2,0
    80003208:	00004597          	auipc	a1,0x4
    8000320c:	1005b583          	ld	a1,256(a1) # 80007308 <_GLOBAL_OFFSET_TABLE_+0x78>
    80003210:	00048513          	mv	a0,s1
    80003214:	fffff097          	auipc	ra,0xfffff
    80003218:	c20080e7          	jalr	-992(ra) # 80001e34 <_ZN3TCB16initializeThreadEPFvPvES0_S0_S0_P10ObjectPoolIS_Lm20EEN12KernelConfig4ModeENS6_11ThreadStateE>
    static void setProducerThread(TCB* thread) { producerThread = thread; }
    8000321c:	00004797          	auipc	a5,0x4
    80003220:	0f47b783          	ld	a5,244(a5) # 80007310 <_GLOBAL_OFFSET_TABLE_+0x80>
    80003224:	0097b023          	sd	s1,0(a5)
}
    80003228:	02813083          	ld	ra,40(sp)
    8000322c:	02013403          	ld	s0,32(sp)
    80003230:	01813483          	ld	s1,24(sp)
    80003234:	01013903          	ld	s2,16(sp)
    80003238:	03010113          	addi	sp,sp,48
    8000323c:	00008067          	ret

0000000080003240 <_ZN6Kernel14makeIdleThreadEv>:
{
    80003240:	fd010113          	addi	sp,sp,-48
    80003244:	02113423          	sd	ra,40(sp)
    80003248:	02813023          	sd	s0,32(sp)
    8000324c:	00913c23          	sd	s1,24(sp)
    80003250:	01213823          	sd	s2,16(sp)
    80003254:	03010413          	addi	s0,sp,48
    void* kernelSystemStack = Kernel::mallocSystemStack(KernelConfig::DEFAULT_SYSTEM_STACK_SIZE);
    80003258:	40000513          	li	a0,1024
    8000325c:	fffff097          	auipc	ra,0xfffff
    80003260:	764080e7          	jalr	1892(ra) # 800029c0 <_ZN6Kernel17mallocSystemStackEm>
    80003264:	00050913          	mv	s2,a0
    TCB* idleThread = poolOfThreads->mallocObject(&sourcePool);
    80003268:	fd840593          	addi	a1,s0,-40
    8000326c:	00004517          	auipc	a0,0x4
    80003270:	39453503          	ld	a0,916(a0) # 80007600 <_ZN6Kernel13poolOfThreadsE>
    80003274:	00000097          	auipc	ra,0x0
    80003278:	41c080e7          	jalr	1052(ra) # 80003690 <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEPPS1_>
    8000327c:	00050493          	mv	s1,a0
    while(!idleThread)
    80003280:	02049063          	bnez	s1,800032a0 <_ZN6Kernel14makeIdleThreadEv+0x60>
        idleThread = poolOfThreads->mallocObject(&sourcePool);
    80003284:	fd840593          	addi	a1,s0,-40
    80003288:	00004517          	auipc	a0,0x4
    8000328c:	37853503          	ld	a0,888(a0) # 80007600 <_ZN6Kernel13poolOfThreadsE>
    80003290:	00000097          	auipc	ra,0x0
    80003294:	400080e7          	jalr	1024(ra) # 80003690 <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEPPS1_>
    80003298:	00050493          	mv	s1,a0
    8000329c:	fe5ff06f          	j	80003280 <_ZN6Kernel14makeIdleThreadEv+0x40>
    idleThread->initializeThread(&kernelWorker, nullptr, kernelSystemStack, kernelSystemStack, sourcePool, KernelConfig::KERNEL_MODE, KernelConfig::BLOCKED);
    800032a0:	00100893          	li	a7,1
    800032a4:	00100813          	li	a6,1
    800032a8:	fd843783          	ld	a5,-40(s0)
    800032ac:	00090713          	mv	a4,s2
    800032b0:	00090693          	mv	a3,s2
    800032b4:	00000613          	li	a2,0
    800032b8:	fffff597          	auipc	a1,0xfffff
    800032bc:	41058593          	addi	a1,a1,1040 # 800026c8 <_ZN6Kernel12kernelWorkerEPv>
    800032c0:	00048513          	mv	a0,s1
    800032c4:	fffff097          	auipc	ra,0xfffff
    800032c8:	b70080e7          	jalr	-1168(ra) # 80001e34 <_ZN3TCB16initializeThreadEPFvPvES0_S0_S0_P10ObjectPoolIS_Lm20EEN12KernelConfig4ModeENS6_11ThreadStateE>
    Scheduler() = delete;
    Scheduler(const Scheduler& scheduler) = delete;
    Scheduler& operator=(const Scheduler& scheduler) = delete;
    static void put(TCB* readyThread);
    static TCB* get(void);
    static void setIdleThread(TCB* thread) { idleThread = thread; }
    800032cc:	00004797          	auipc	a5,0x4
    800032d0:	01c7b783          	ld	a5,28(a5) # 800072e8 <_GLOBAL_OFFSET_TABLE_+0x58>
    800032d4:	0097b023          	sd	s1,0(a5)
}
    800032d8:	02813083          	ld	ra,40(sp)
    800032dc:	02013403          	ld	s0,32(sp)
    800032e0:	01813483          	ld	s1,24(sp)
    800032e4:	01013903          	ld	s2,16(sp)
    800032e8:	03010113          	addi	sp,sp,48
    800032ec:	00008067          	ret

00000000800032f0 <_ZN6Kernel23initializeKernelThreadsEv>:
{
    800032f0:	ff010113          	addi	sp,sp,-16
    800032f4:	00113423          	sd	ra,8(sp)
    800032f8:	00813023          	sd	s0,0(sp)
    800032fc:	01010413          	addi	s0,sp,16
    makeConsumerThread();
    80003300:	00000097          	auipc	ra,0x0
    80003304:	de0080e7          	jalr	-544(ra) # 800030e0 <_ZN6Kernel18makeConsumerThreadEv>
    makeProducerThread();
    80003308:	00000097          	auipc	ra,0x0
    8000330c:	e88080e7          	jalr	-376(ra) # 80003190 <_ZN6Kernel18makeProducerThreadEv>
    makeIdleThread();
    80003310:	00000097          	auipc	ra,0x0
    80003314:	f30080e7          	jalr	-208(ra) # 80003240 <_ZN6Kernel14makeIdleThreadEv>
}
    80003318:	00813083          	ld	ra,8(sp)
    8000331c:	00013403          	ld	s0,0(sp)
    80003320:	01010113          	addi	sp,sp,16
    80003324:	00008067          	ret

0000000080003328 <_ZN6Kernel16initializeKernelEv>:
{
    80003328:	fe010113          	addi	sp,sp,-32
    8000332c:	00113c23          	sd	ra,24(sp)
    80003330:	00813823          	sd	s0,16(sp)
    80003334:	00913423          	sd	s1,8(sp)
    80003338:	02010413          	addi	s0,sp,32

};

inline void Kernel::setInterruptRoutine(void (*routine)(void))
{
    Machine::writeStvec((uint64) routine);
    8000333c:	00004797          	auipc	a5,0x4
    80003340:	f8c7b783          	ld	a5,-116(a5) # 800072c8 <_GLOBAL_OFFSET_TABLE_+0x38>
    __asm__ volatile ("csrw stvec, %[address]": : [address] "r"(interruptAddress));
    80003344:	10579073          	csrw	stvec,a5
}
    80003348:	0180006f          	j	80003360 <_ZN6Kernel16initializeKernelEv+0x38>
    8000334c:	000017b7          	lui	a5,0x1
    80003350:	00f507b3          	add	a5,a0,a5
    80003354:	8a07bc23          	sd	zero,-1864(a5) # 8b8 <_entry-0x7ffff748>
     poolOfThreads = new ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>();
    80003358:	00004797          	auipc	a5,0x4
    8000335c:	2aa7b423          	sd	a0,680(a5) # 80007600 <_ZN6Kernel13poolOfThreadsE>
    while(!poolOfThreads)
    80003360:	00004797          	auipc	a5,0x4
    80003364:	2a07b783          	ld	a5,672(a5) # 80007600 <_ZN6Kernel13poolOfThreadsE>
    80003368:	06079663          	bnez	a5,800033d4 <_ZN6Kernel16initializeKernelEv+0xac>
     poolOfThreads = new ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>();
    8000336c:	000014b7          	lui	s1,0x1
    80003370:	8d848513          	addi	a0,s1,-1832 # 8d8 <_entry-0x7ffff728>
    80003374:	00000097          	auipc	ra,0x0
    80003378:	208080e7          	jalr	520(ra) # 8000357c <_ZN10ObjectPoolI3TCBLm20EEnwEm>
    ObjectPool(): headFreeObject(pool), nextObjectPool(nullptr), prevObjectPool(nullptr)
    8000337c:	009507b3          	add	a5,a0,s1
    80003380:	8ca7b023          	sd	a0,-1856(a5)
    80003384:	8c07b423          	sd	zero,-1848(a5)
    80003388:	8c07b823          	sd	zero,-1840(a5)
        for(size_t i = 0; i < numOfObjects - 1; i++)
    8000338c:	00000693          	li	a3,0
    80003390:	01200793          	li	a5,18
    80003394:	fad7ece3          	bltu	a5,a3,8000334c <_ZN6Kernel16initializeKernelEv+0x24>
            pool[i].nextFree = &(pool[i+1]);
    80003398:	00168613          	addi	a2,a3,1
    8000339c:	00361713          	slli	a4,a2,0x3
    800033a0:	40c70733          	sub	a4,a4,a2
    800033a4:	00471713          	slli	a4,a4,0x4
    800033a8:	00e50733          	add	a4,a0,a4
    800033ac:	00369793          	slli	a5,a3,0x3
    800033b0:	40d787b3          	sub	a5,a5,a3
    800033b4:	00479793          	slli	a5,a5,0x4
    800033b8:	00f507b3          	add	a5,a0,a5
    800033bc:	06e7b423          	sd	a4,104(a5)
        for(size_t i = 0; i < numOfObjects - 1; i++)
    800033c0:	00060693          	mv	a3,a2
    800033c4:	fcdff06f          	j	80003390 <_ZN6Kernel16initializeKernelEv+0x68>
        pool[numOfObjects - 1].nextFree = nullptr;
    800033c8:	12053c23          	sd	zero,312(a0)
        poolOfSemaphores = new ObjectPool<KSemaphore, KernelConfig::NUM_OF_SEMAPHORES_IN_POOL>();
    800033cc:	00004797          	auipc	a5,0x4
    800033d0:	22a7be23          	sd	a0,572(a5) # 80007608 <_ZN6Kernel16poolOfSemaphoresE>
    while(!poolOfSemaphores)
    800033d4:	00004797          	auipc	a5,0x4
    800033d8:	2347b783          	ld	a5,564(a5) # 80007608 <_ZN6Kernel16poolOfSemaphoresE>
    800033dc:	04079463          	bnez	a5,80003424 <_ZN6Kernel16initializeKernelEv+0xfc>
        poolOfSemaphores = new ObjectPool<KSemaphore, KernelConfig::NUM_OF_SEMAPHORES_IN_POOL>();
    800033e0:	15800513          	li	a0,344
    800033e4:	00000097          	auipc	ra,0x0
    800033e8:	1d4080e7          	jalr	468(ra) # 800035b8 <_ZN10ObjectPoolI10KSemaphoreLm10EEnwEm>
    ObjectPool(): headFreeObject(pool), nextObjectPool(nullptr), prevObjectPool(nullptr)
    800033ec:	14a53023          	sd	a0,320(a0)
    800033f0:	14053423          	sd	zero,328(a0)
    800033f4:	14053823          	sd	zero,336(a0)
        for(size_t i = 0; i < numOfObjects - 1; i++)
    800033f8:	00000793          	li	a5,0
    800033fc:	00800713          	li	a4,8
    80003400:	fcf764e3          	bltu	a4,a5,800033c8 <_ZN6Kernel16initializeKernelEv+0xa0>
            pool[i].nextFree = &(pool[i+1]);
    80003404:	00178693          	addi	a3,a5,1
    80003408:	00569713          	slli	a4,a3,0x5
    8000340c:	00e50733          	add	a4,a0,a4
    80003410:	00579793          	slli	a5,a5,0x5
    80003414:	00f507b3          	add	a5,a0,a5
    80003418:	00e7bc23          	sd	a4,24(a5)
        for(size_t i = 0; i < numOfObjects - 1; i++)
    8000341c:	00068793          	mv	a5,a3
    80003420:	fddff06f          	j	800033fc <_ZN6Kernel16initializeKernelEv+0xd4>
    initializeKernelThreads();
    80003424:	00000097          	auipc	ra,0x0
    80003428:	ecc080e7          	jalr	-308(ra) # 800032f0 <_ZN6Kernel23initializeKernelThreadsEv>
    initializeSystemCalls();
    8000342c:	fffff097          	auipc	ra,0xfffff
    80003430:	67c080e7          	jalr	1660(ra) # 80002aa8 <_ZN6Kernel21initializeSystemCallsEv>
}
    80003434:	01813083          	ld	ra,24(sp)
    80003438:	01013403          	ld	s0,16(sp)
    8000343c:	00813483          	ld	s1,8(sp)
    80003440:	02010113          	addi	sp,sp,32
    80003444:	00008067          	ret

0000000080003448 <_ZN6Kernel15sysThreadCreateEPNS_21ArgumentsOfSystemCallE>:
{
    80003448:	fd010113          	addi	sp,sp,-48
    8000344c:	02113423          	sd	ra,40(sp)
    80003450:	02813023          	sd	s0,32(sp)
    80003454:	00913c23          	sd	s1,24(sp)
    80003458:	01213823          	sd	s2,16(sp)
    8000345c:	03010413          	addi	s0,sp,48
    80003460:	00050493          	mv	s1,a0
    TCB* newThread = poolOfThreads->mallocObject(&sourcePool);
    80003464:	fd840593          	addi	a1,s0,-40
    80003468:	00004517          	auipc	a0,0x4
    8000346c:	19853503          	ld	a0,408(a0) # 80007600 <_ZN6Kernel13poolOfThreadsE>
    80003470:	00000097          	auipc	ra,0x0
    80003474:	220080e7          	jalr	544(ra) # 80003690 <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEPPS1_>
    if(!newThread)
    80003478:	06050063          	beqz	a0,800034d8 <_ZN6Kernel15sysThreadCreateEPNS_21ArgumentsOfSystemCallE+0x90>
    8000347c:	00050913          	mv	s2,a0
    __asm__ volatile("sd %[ptrThread], 0(%[handle])"::[ptrThread]"r"(newThread), [handle]"r"(arg->a0));
    80003480:	0004b783          	ld	a5,0(s1)
    80003484:	00a7b023          	sd	a0,0(a5)
    void* kernelSystemStack = Kernel::mallocSystemStack(KernelConfig::DEFAULT_SYSTEM_STACK_SIZE);
    80003488:	40000513          	li	a0,1024
    8000348c:	fffff097          	auipc	ra,0xfffff
    80003490:	534080e7          	jalr	1332(ra) # 800029c0 <_ZN6Kernel17mallocSystemStackEm>
    80003494:	00050713          	mv	a4,a0
    newThread->initializeThread((TCB::Body) arg->a1, (void*)arg->a2, (void*)arg->a3, kernelSystemStack, sourcePool);
    80003498:	00000893          	li	a7,0
    8000349c:	00000813          	li	a6,0
    800034a0:	fd843783          	ld	a5,-40(s0)
    800034a4:	0184b683          	ld	a3,24(s1)
    800034a8:	0104b603          	ld	a2,16(s1)
    800034ac:	0084b583          	ld	a1,8(s1)
    800034b0:	00090513          	mv	a0,s2
    800034b4:	fffff097          	auipc	ra,0xfffff
    800034b8:	980080e7          	jalr	-1664(ra) # 80001e34 <_ZN3TCB16initializeThreadEPFvPvES0_S0_S0_P10ObjectPoolIS_Lm20EEN12KernelConfig4ModeENS6_11ThreadStateE>
    return 0;
    800034bc:	00000513          	li	a0,0
}
    800034c0:	02813083          	ld	ra,40(sp)
    800034c4:	02013403          	ld	s0,32(sp)
    800034c8:	01813483          	ld	s1,24(sp)
    800034cc:	01013903          	ld	s2,16(sp)
    800034d0:	03010113          	addi	sp,sp,48
    800034d4:	00008067          	ret
        return -1;
    800034d8:	fff00513          	li	a0,-1
    800034dc:	fe5ff06f          	j	800034c0 <_ZN6Kernel15sysThreadCreateEPNS_21ArgumentsOfSystemCallE+0x78>

00000000800034e0 <_ZN6Kernel16sysSemaphoreOpenEPNS_21ArgumentsOfSystemCallE>:
{
    800034e0:	fd010113          	addi	sp,sp,-48
    800034e4:	02113423          	sd	ra,40(sp)
    800034e8:	02813023          	sd	s0,32(sp)
    800034ec:	00913c23          	sd	s1,24(sp)
    800034f0:	03010413          	addi	s0,sp,48
    800034f4:	00050493          	mv	s1,a0
    KSemaphore* newSemaphore = poolOfSemaphores->mallocObject(&sourcePool);
    800034f8:	fd840593          	addi	a1,s0,-40
    800034fc:	00004517          	auipc	a0,0x4
    80003500:	10c53503          	ld	a0,268(a0) # 80007608 <_ZN6Kernel16poolOfSemaphoresE>
    80003504:	00000097          	auipc	ra,0x0
    80003508:	2bc080e7          	jalr	700(ra) # 800037c0 <_ZN10ObjectPoolI10KSemaphoreLm10EE12mallocObjectEPPS1_>
    if(!newSemaphore)
    8000350c:	02050a63          	beqz	a0,80003540 <_ZN6Kernel16sysSemaphoreOpenEPNS_21ArgumentsOfSystemCallE+0x60>
    __asm__ volatile("sd %[ptrSemaphore], 0(%[handle])"::[ptrSemaphore]"r"(newSemaphore), [handle]"r"(arg->a0));
    80003510:	0004b783          	ld	a5,0(s1)
    80003514:	00a7b023          	sd	a0,0(a5)
    newSemaphore->initializeSemaphore((unsigned)arg->a1, sourcePool);
    80003518:	fd843603          	ld	a2,-40(s0)
    8000351c:	0084a583          	lw	a1,8(s1)
    80003520:	fffff097          	auipc	ra,0xfffff
    80003524:	eac080e7          	jalr	-340(ra) # 800023cc <_ZN10KSemaphore19initializeSemaphoreEjP10ObjectPoolIS_Lm10EE>
    return 0;
    80003528:	00000513          	li	a0,0
}
    8000352c:	02813083          	ld	ra,40(sp)
    80003530:	02013403          	ld	s0,32(sp)
    80003534:	01813483          	ld	s1,24(sp)
    80003538:	03010113          	addi	sp,sp,48
    8000353c:	00008067          	ret
        return -1;
    80003540:	fff00513          	li	a0,-1
    80003544:	fe9ff06f          	j	8000352c <_ZN6Kernel16sysSemaphoreOpenEPNS_21ArgumentsOfSystemCallE+0x4c>

0000000080003548 <_GLOBAL__sub_I__ZN6Kernel16systemCallsTableE>:
    80003548:	ff010113          	addi	sp,sp,-16
    8000354c:	00113423          	sd	ra,8(sp)
    80003550:	00813023          	sd	s0,0(sp)
    80003554:	01010413          	addi	s0,sp,16
    80003558:	000105b7          	lui	a1,0x10
    8000355c:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    80003560:	00100513          	li	a0,1
    80003564:	00000097          	auipc	ra,0x0
    80003568:	94c080e7          	jalr	-1716(ra) # 80002eb0 <_Z41__static_initialization_and_destruction_0ii>
    8000356c:	00813083          	ld	ra,8(sp)
    80003570:	00013403          	ld	s0,0(sp)
    80003574:	01010113          	addi	sp,sp,16
    80003578:	00008067          	ret

000000008000357c <_ZN10ObjectPoolI3TCBLm20EEnwEm>:

};


template<typename T, size_t numOfObjects>
void* ObjectPool<T, numOfObjects>::operator new(size_t size)
    8000357c:	ff010113          	addi	sp,sp,-16
    80003580:	00113423          	sd	ra,8(sp)
    80003584:	00813023          	sd	s0,0(sp)
    80003588:	01010413          	addi	s0,sp,16
{
    size_t numOfBlocks = size / MEM_BLOCK_SIZE;
    8000358c:	00655793          	srli	a5,a0,0x6
    numOfBlocks += size % MEM_BLOCK_SIZE ? 1 : 0;
    80003590:	03f57513          	andi	a0,a0,63
    80003594:	00050463          	beqz	a0,8000359c <_ZN10ObjectPoolI3TCBLm20EEnwEm+0x20>
    80003598:	00100513          	li	a0,1
    return MemoryAllocator::allocateMemory(numOfBlocks);
    8000359c:	00f50533          	add	a0,a0,a5
    800035a0:	fffff097          	auipc	ra,0xfffff
    800035a4:	b64080e7          	jalr	-1180(ra) # 80002104 <_ZN15MemoryAllocator14allocateMemoryEm>
}
    800035a8:	00813083          	ld	ra,8(sp)
    800035ac:	00013403          	ld	s0,0(sp)
    800035b0:	01010113          	addi	sp,sp,16
    800035b4:	00008067          	ret

00000000800035b8 <_ZN10ObjectPoolI10KSemaphoreLm10EEnwEm>:
void* ObjectPool<T, numOfObjects>::operator new(size_t size)
    800035b8:	ff010113          	addi	sp,sp,-16
    800035bc:	00113423          	sd	ra,8(sp)
    800035c0:	00813023          	sd	s0,0(sp)
    800035c4:	01010413          	addi	s0,sp,16
    size_t numOfBlocks = size / MEM_BLOCK_SIZE;
    800035c8:	00655793          	srli	a5,a0,0x6
    numOfBlocks += size % MEM_BLOCK_SIZE ? 1 : 0;
    800035cc:	03f57513          	andi	a0,a0,63
    800035d0:	00050463          	beqz	a0,800035d8 <_ZN10ObjectPoolI10KSemaphoreLm10EEnwEm+0x20>
    800035d4:	00100513          	li	a0,1
    return MemoryAllocator::allocateMemory(numOfBlocks);
    800035d8:	00f50533          	add	a0,a0,a5
    800035dc:	fffff097          	auipc	ra,0xfffff
    800035e0:	b28080e7          	jalr	-1240(ra) # 80002104 <_ZN15MemoryAllocator14allocateMemoryEm>
}
    800035e4:	00813083          	ld	ra,8(sp)
    800035e8:	00013403          	ld	s0,0(sp)
    800035ec:	01010113          	addi	sp,sp,16
    800035f0:	00008067          	ret

00000000800035f4 <_ZN10ObjectPoolI3TCBLm20EE10freeObjectEPS0_>:
        return &(temp->object);
    }
}

template<typename T, size_t numOfObjects>
int ObjectPool<T, numOfObjects>::freeObject(T *obj) {
    800035f4:	ff010113          	addi	sp,sp,-16
    800035f8:	00813423          	sd	s0,8(sp)
    800035fc:	01010413          	addi	s0,sp,16
    ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>* getSourcePool() { return sourcePool; }
    80003600:	0605b783          	ld	a5,96(a1)
////        {
////            break;
////        }
////    }
    PoolObject* tempObj = (PoolObject*)obj;
    tempObj->nextFree = curr->headFreeObject;
    80003604:	00001737          	lui	a4,0x1
    80003608:	00e787b3          	add	a5,a5,a4
    8000360c:	8c07b703          	ld	a4,-1856(a5)
    80003610:	06e5b423          	sd	a4,104(a1)
    curr->headFreeObject = tempObj;
    80003614:	8cb7b023          	sd	a1,-1856(a5)

    return 0;
}
    80003618:	00000513          	li	a0,0
    8000361c:	00813403          	ld	s0,8(sp)
    80003620:	01010113          	addi	sp,sp,16
    80003624:	00008067          	ret

0000000080003628 <_ZN10ObjectPoolI10KSemaphoreLm10EE10freeObjectEPS0_>:
int ObjectPool<T, numOfObjects>::freeObject(T *obj) {
    80003628:	ff010113          	addi	sp,sp,-16
    8000362c:	00813423          	sd	s0,8(sp)
    80003630:	01010413          	addi	s0,sp,16
class KSemaphore {
public:
    KSemaphore() = default;
    void initializeSemaphore(unsigned value, ObjectPool<KSemaphore, KernelConfig::NUM_OF_SEMAPHORES_IN_POOL>* pool);
    void removeThreadFromBlockedQueue(TCB* thread);
    ObjectPool<KSemaphore, KernelConfig::NUM_OF_SEMAPHORES_IN_POOL>* getSourcePool() { return sourcePool; }
    80003634:	0105b783          	ld	a5,16(a1)
    tempObj->nextFree = curr->headFreeObject;
    80003638:	1407b703          	ld	a4,320(a5)
    8000363c:	00e5bc23          	sd	a4,24(a1)
    curr->headFreeObject = tempObj;
    80003640:	14b7b023          	sd	a1,320(a5)
}
    80003644:	00000513          	li	a0,0
    80003648:	00813403          	ld	s0,8(sp)
    8000364c:	01010113          	addi	sp,sp,16
    80003650:	00008067          	ret

0000000080003654 <_ZN10ObjectPoolI3TCBLm20EE12findFreePoolEv>:
ObjectPool<T, numOfObjects>* ObjectPool<T, numOfObjects>::findFreePool(void)
    80003654:	ff010113          	addi	sp,sp,-16
    80003658:	00813423          	sd	s0,8(sp)
    8000365c:	01010413          	addi	s0,sp,16
    80003660:	00050793          	mv	a5,a0
    for(; !curr->nextObjectPool && !curr->headFreeObject; curr = curr->nextObjectPool);
    80003664:	00078513          	mv	a0,a5
    80003668:	00001737          	lui	a4,0x1
    8000366c:	00e787b3          	add	a5,a5,a4
    80003670:	8c87b783          	ld	a5,-1848(a5)
    80003674:	00079863          	bnez	a5,80003684 <_ZN10ObjectPoolI3TCBLm20EE12findFreePoolEv+0x30>
    80003678:	00e50733          	add	a4,a0,a4
    8000367c:	8c073703          	ld	a4,-1856(a4) # 8c0 <_entry-0x7ffff740>
    80003680:	fe0702e3          	beqz	a4,80003664 <_ZN10ObjectPoolI3TCBLm20EE12findFreePoolEv+0x10>
}
    80003684:	00813403          	ld	s0,8(sp)
    80003688:	01010113          	addi	sp,sp,16
    8000368c:	00008067          	ret

0000000080003690 <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEPPS1_>:
T* ObjectPool<T, numOfObjects>::mallocObject(ObjectPool<T, numOfObjects>** addressOfPool)
    80003690:	fd010113          	addi	sp,sp,-48
    80003694:	02113423          	sd	ra,40(sp)
    80003698:	02813023          	sd	s0,32(sp)
    8000369c:	00913c23          	sd	s1,24(sp)
    800036a0:	01213823          	sd	s2,16(sp)
    800036a4:	01313423          	sd	s3,8(sp)
    800036a8:	03010413          	addi	s0,sp,48
    800036ac:	00058913          	mv	s2,a1
    ObjectPool<T,numOfObjects>* currentPool = findFreePool();
    800036b0:	00000097          	auipc	ra,0x0
    800036b4:	fa4080e7          	jalr	-92(ra) # 80003654 <_ZN10ObjectPoolI3TCBLm20EE12findFreePoolEv>
    800036b8:	00050493          	mv	s1,a0
    if (currentPool->headFreeObject)
    800036bc:	000017b7          	lui	a5,0x1
    800036c0:	00f507b3          	add	a5,a0,a5
    800036c4:	8c07b503          	ld	a0,-1856(a5) # 8c0 <_entry-0x7ffff740>
    800036c8:	02050a63          	beqz	a0,800036fc <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEPPS1_+0x6c>
        currentPool->headFreeObject = currentPool->headFreeObject->nextFree;
    800036cc:	06853703          	ld	a4,104(a0)
    800036d0:	000017b7          	lui	a5,0x1
    800036d4:	00f487b3          	add	a5,s1,a5
    800036d8:	8ce7b023          	sd	a4,-1856(a5) # 8c0 <_entry-0x7ffff740>
        *addressOfPool = currentPool;
    800036dc:	00993023          	sd	s1,0(s2)
}
    800036e0:	02813083          	ld	ra,40(sp)
    800036e4:	02013403          	ld	s0,32(sp)
    800036e8:	01813483          	ld	s1,24(sp)
    800036ec:	01013903          	ld	s2,16(sp)
    800036f0:	00813983          	ld	s3,8(sp)
    800036f4:	03010113          	addi	sp,sp,48
    800036f8:	00008067          	ret
        ObjectPool<T, numOfObjects>* newPool = new ObjectPool();
    800036fc:	000019b7          	lui	s3,0x1
    80003700:	8d898513          	addi	a0,s3,-1832 # 8d8 <_entry-0x7ffff728>
    80003704:	00000097          	auipc	ra,0x0
    80003708:	e78080e7          	jalr	-392(ra) # 8000357c <_ZN10ObjectPoolI3TCBLm20EEnwEm>
    ObjectPool(): headFreeObject(pool), nextObjectPool(nullptr), prevObjectPool(nullptr)
    8000370c:	013507b3          	add	a5,a0,s3
    80003710:	8ca7b023          	sd	a0,-1856(a5)
    80003714:	8c07b423          	sd	zero,-1848(a5)
    80003718:	8c07b823          	sd	zero,-1840(a5)
        for(size_t i = 0; i < numOfObjects - 1; i++)
    8000371c:	00000693          	li	a3,0
    80003720:	01200793          	li	a5,18
    80003724:	02d7ea63          	bltu	a5,a3,80003758 <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEPPS1_+0xc8>
            pool[i].nextFree = &(pool[i+1]);
    80003728:	00168613          	addi	a2,a3,1
    8000372c:	00361713          	slli	a4,a2,0x3
    80003730:	40c70733          	sub	a4,a4,a2
    80003734:	00471713          	slli	a4,a4,0x4
    80003738:	00e50733          	add	a4,a0,a4
    8000373c:	00369793          	slli	a5,a3,0x3
    80003740:	40d787b3          	sub	a5,a5,a3
    80003744:	00479793          	slli	a5,a5,0x4
    80003748:	00f507b3          	add	a5,a0,a5
    8000374c:	06e7b423          	sd	a4,104(a5)
        for(size_t i = 0; i < numOfObjects - 1; i++)
    80003750:	00060693          	mv	a3,a2
    80003754:	fcdff06f          	j	80003720 <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEPPS1_+0x90>
        pool[numOfObjects - 1].nextFree = nullptr;
    80003758:	000017b7          	lui	a5,0x1
    8000375c:	00f507b3          	add	a5,a0,a5
    80003760:	8a07bc23          	sd	zero,-1864(a5) # 8b8 <_entry-0x7ffff748>
        if(!newPool)
    80003764:	f6050ee3          	beqz	a0,800036e0 <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEPPS1_+0x50>
        newPool->prevObjectPool = currentPool;
    80003768:	00001737          	lui	a4,0x1
    8000376c:	8c97b823          	sd	s1,-1840(a5)
        currentPool->nextObjectPool = newPool;
    80003770:	00e484b3          	add	s1,s1,a4
    80003774:	8ca4b423          	sd	a0,-1848(s1)
        PoolObject* temp = newPool->headFreeObject;
    80003778:	8c07b703          	ld	a4,-1856(a5)
        newPool->headFreeObject = newPool->headFreeObject->nextFree;
    8000377c:	06873683          	ld	a3,104(a4) # 1068 <_entry-0x7fffef98>
    80003780:	8cd7b023          	sd	a3,-1856(a5)
        *addressOfPool = newPool;
    80003784:	00a93023          	sd	a0,0(s2)
        return &(temp->object);
    80003788:	00070513          	mv	a0,a4
    8000378c:	f55ff06f          	j	800036e0 <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEPPS1_+0x50>

0000000080003790 <_ZN10ObjectPoolI10KSemaphoreLm10EE12findFreePoolEv>:
ObjectPool<T, numOfObjects>* ObjectPool<T, numOfObjects>::findFreePool(void)
    80003790:	ff010113          	addi	sp,sp,-16
    80003794:	00813423          	sd	s0,8(sp)
    80003798:	01010413          	addi	s0,sp,16
    8000379c:	00050793          	mv	a5,a0
    for(; !curr->nextObjectPool && !curr->headFreeObject; curr = curr->nextObjectPool);
    800037a0:	00078513          	mv	a0,a5
    800037a4:	1487b783          	ld	a5,328(a5)
    800037a8:	00079663          	bnez	a5,800037b4 <_ZN10ObjectPoolI10KSemaphoreLm10EE12findFreePoolEv+0x24>
    800037ac:	14053703          	ld	a4,320(a0)
    800037b0:	fe0708e3          	beqz	a4,800037a0 <_ZN10ObjectPoolI10KSemaphoreLm10EE12findFreePoolEv+0x10>
}
    800037b4:	00813403          	ld	s0,8(sp)
    800037b8:	01010113          	addi	sp,sp,16
    800037bc:	00008067          	ret

00000000800037c0 <_ZN10ObjectPoolI10KSemaphoreLm10EE12mallocObjectEPPS1_>:
T* ObjectPool<T, numOfObjects>::mallocObject(ObjectPool<T, numOfObjects>** addressOfPool)
    800037c0:	fe010113          	addi	sp,sp,-32
    800037c4:	00113c23          	sd	ra,24(sp)
    800037c8:	00813823          	sd	s0,16(sp)
    800037cc:	00913423          	sd	s1,8(sp)
    800037d0:	01213023          	sd	s2,0(sp)
    800037d4:	02010413          	addi	s0,sp,32
    800037d8:	00058913          	mv	s2,a1
    ObjectPool<T,numOfObjects>* currentPool = findFreePool();
    800037dc:	00000097          	auipc	ra,0x0
    800037e0:	fb4080e7          	jalr	-76(ra) # 80003790 <_ZN10ObjectPoolI10KSemaphoreLm10EE12findFreePoolEv>
    800037e4:	00050493          	mv	s1,a0
    if (currentPool->headFreeObject)
    800037e8:	14053503          	ld	a0,320(a0)
    800037ec:	02050463          	beqz	a0,80003814 <_ZN10ObjectPoolI10KSemaphoreLm10EE12mallocObjectEPPS1_+0x54>
        currentPool->headFreeObject = currentPool->headFreeObject->nextFree;
    800037f0:	01853783          	ld	a5,24(a0)
    800037f4:	14f4b023          	sd	a5,320(s1)
        *addressOfPool = currentPool;
    800037f8:	00993023          	sd	s1,0(s2)
}
    800037fc:	01813083          	ld	ra,24(sp)
    80003800:	01013403          	ld	s0,16(sp)
    80003804:	00813483          	ld	s1,8(sp)
    80003808:	00013903          	ld	s2,0(sp)
    8000380c:	02010113          	addi	sp,sp,32
    80003810:	00008067          	ret
        ObjectPool<T, numOfObjects>* newPool = new ObjectPool();
    80003814:	15800513          	li	a0,344
    80003818:	00000097          	auipc	ra,0x0
    8000381c:	da0080e7          	jalr	-608(ra) # 800035b8 <_ZN10ObjectPoolI10KSemaphoreLm10EEnwEm>
    ObjectPool(): headFreeObject(pool), nextObjectPool(nullptr), prevObjectPool(nullptr)
    80003820:	14a53023          	sd	a0,320(a0)
    80003824:	14053423          	sd	zero,328(a0)
    80003828:	14053823          	sd	zero,336(a0)
        for(size_t i = 0; i < numOfObjects - 1; i++)
    8000382c:	00000793          	li	a5,0
    80003830:	0200006f          	j	80003850 <_ZN10ObjectPoolI10KSemaphoreLm10EE12mallocObjectEPPS1_+0x90>
            pool[i].nextFree = &(pool[i+1]);
    80003834:	00178693          	addi	a3,a5,1
    80003838:	00569713          	slli	a4,a3,0x5
    8000383c:	00e50733          	add	a4,a0,a4
    80003840:	00579793          	slli	a5,a5,0x5
    80003844:	00f507b3          	add	a5,a0,a5
    80003848:	00e7bc23          	sd	a4,24(a5)
        for(size_t i = 0; i < numOfObjects - 1; i++)
    8000384c:	00068793          	mv	a5,a3
    80003850:	00800713          	li	a4,8
    80003854:	fef770e3          	bgeu	a4,a5,80003834 <_ZN10ObjectPoolI10KSemaphoreLm10EE12mallocObjectEPPS1_+0x74>
        pool[numOfObjects - 1].nextFree = nullptr;
    80003858:	12053c23          	sd	zero,312(a0)
        if(!newPool)
    8000385c:	fa0500e3          	beqz	a0,800037fc <_ZN10ObjectPoolI10KSemaphoreLm10EE12mallocObjectEPPS1_+0x3c>
        newPool->prevObjectPool = currentPool;
    80003860:	14953823          	sd	s1,336(a0)
        currentPool->nextObjectPool = newPool;
    80003864:	14a4b423          	sd	a0,328(s1)
        PoolObject* temp = newPool->headFreeObject;
    80003868:	14053783          	ld	a5,320(a0)
        newPool->headFreeObject = newPool->headFreeObject->nextFree;
    8000386c:	0187b703          	ld	a4,24(a5)
    80003870:	14e53023          	sd	a4,320(a0)
        *addressOfPool = newPool;
    80003874:	00a93023          	sd	a0,0(s2)
        return &(temp->object);
    80003878:	00078513          	mv	a0,a5
    8000387c:	f81ff06f          	j	800037fc <_ZN10ObjectPoolI10KSemaphoreLm10EE12mallocObjectEPPS1_+0x3c>

0000000080003880 <start>:
    80003880:	ff010113          	addi	sp,sp,-16
    80003884:	00813423          	sd	s0,8(sp)
    80003888:	01010413          	addi	s0,sp,16
    8000388c:	300027f3          	csrr	a5,mstatus
    80003890:	ffffe737          	lui	a4,0xffffe
    80003894:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff5f9f>
    80003898:	00e7f7b3          	and	a5,a5,a4
    8000389c:	00001737          	lui	a4,0x1
    800038a0:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    800038a4:	00e7e7b3          	or	a5,a5,a4
    800038a8:	30079073          	csrw	mstatus,a5
    800038ac:	00000797          	auipc	a5,0x0
    800038b0:	16078793          	addi	a5,a5,352 # 80003a0c <system_main>
    800038b4:	34179073          	csrw	mepc,a5
    800038b8:	00000793          	li	a5,0
    800038bc:	18079073          	csrw	satp,a5
    800038c0:	000107b7          	lui	a5,0x10
    800038c4:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    800038c8:	30279073          	csrw	medeleg,a5
    800038cc:	30379073          	csrw	mideleg,a5
    800038d0:	104027f3          	csrr	a5,sie
    800038d4:	2227e793          	ori	a5,a5,546
    800038d8:	10479073          	csrw	sie,a5
    800038dc:	fff00793          	li	a5,-1
    800038e0:	00a7d793          	srli	a5,a5,0xa
    800038e4:	3b079073          	csrw	pmpaddr0,a5
    800038e8:	00f00793          	li	a5,15
    800038ec:	3a079073          	csrw	pmpcfg0,a5
    800038f0:	f14027f3          	csrr	a5,mhartid
    800038f4:	0200c737          	lui	a4,0x200c
    800038f8:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800038fc:	0007869b          	sext.w	a3,a5
    80003900:	00269713          	slli	a4,a3,0x2
    80003904:	000f4637          	lui	a2,0xf4
    80003908:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    8000390c:	00d70733          	add	a4,a4,a3
    80003910:	0037979b          	slliw	a5,a5,0x3
    80003914:	020046b7          	lui	a3,0x2004
    80003918:	00d787b3          	add	a5,a5,a3
    8000391c:	00c585b3          	add	a1,a1,a2
    80003920:	00371693          	slli	a3,a4,0x3
    80003924:	00004717          	auipc	a4,0x4
    80003928:	cec70713          	addi	a4,a4,-788 # 80007610 <timer_scratch>
    8000392c:	00b7b023          	sd	a1,0(a5)
    80003930:	00d70733          	add	a4,a4,a3
    80003934:	00f73c23          	sd	a5,24(a4)
    80003938:	02c73023          	sd	a2,32(a4)
    8000393c:	34071073          	csrw	mscratch,a4
    80003940:	00000797          	auipc	a5,0x0
    80003944:	6e078793          	addi	a5,a5,1760 # 80004020 <timervec>
    80003948:	30579073          	csrw	mtvec,a5
    8000394c:	300027f3          	csrr	a5,mstatus
    80003950:	0087e793          	ori	a5,a5,8
    80003954:	30079073          	csrw	mstatus,a5
    80003958:	304027f3          	csrr	a5,mie
    8000395c:	0807e793          	ori	a5,a5,128
    80003960:	30479073          	csrw	mie,a5
    80003964:	f14027f3          	csrr	a5,mhartid
    80003968:	0007879b          	sext.w	a5,a5
    8000396c:	00078213          	mv	tp,a5
    80003970:	30200073          	mret
    80003974:	00813403          	ld	s0,8(sp)
    80003978:	01010113          	addi	sp,sp,16
    8000397c:	00008067          	ret

0000000080003980 <timerinit>:
    80003980:	ff010113          	addi	sp,sp,-16
    80003984:	00813423          	sd	s0,8(sp)
    80003988:	01010413          	addi	s0,sp,16
    8000398c:	f14027f3          	csrr	a5,mhartid
    80003990:	0200c737          	lui	a4,0x200c
    80003994:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80003998:	0007869b          	sext.w	a3,a5
    8000399c:	00269713          	slli	a4,a3,0x2
    800039a0:	000f4637          	lui	a2,0xf4
    800039a4:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800039a8:	00d70733          	add	a4,a4,a3
    800039ac:	0037979b          	slliw	a5,a5,0x3
    800039b0:	020046b7          	lui	a3,0x2004
    800039b4:	00d787b3          	add	a5,a5,a3
    800039b8:	00c585b3          	add	a1,a1,a2
    800039bc:	00371693          	slli	a3,a4,0x3
    800039c0:	00004717          	auipc	a4,0x4
    800039c4:	c5070713          	addi	a4,a4,-944 # 80007610 <timer_scratch>
    800039c8:	00b7b023          	sd	a1,0(a5)
    800039cc:	00d70733          	add	a4,a4,a3
    800039d0:	00f73c23          	sd	a5,24(a4)
    800039d4:	02c73023          	sd	a2,32(a4)
    800039d8:	34071073          	csrw	mscratch,a4
    800039dc:	00000797          	auipc	a5,0x0
    800039e0:	64478793          	addi	a5,a5,1604 # 80004020 <timervec>
    800039e4:	30579073          	csrw	mtvec,a5
    800039e8:	300027f3          	csrr	a5,mstatus
    800039ec:	0087e793          	ori	a5,a5,8
    800039f0:	30079073          	csrw	mstatus,a5
    800039f4:	304027f3          	csrr	a5,mie
    800039f8:	0807e793          	ori	a5,a5,128
    800039fc:	30479073          	csrw	mie,a5
    80003a00:	00813403          	ld	s0,8(sp)
    80003a04:	01010113          	addi	sp,sp,16
    80003a08:	00008067          	ret

0000000080003a0c <system_main>:
    80003a0c:	fe010113          	addi	sp,sp,-32
    80003a10:	00813823          	sd	s0,16(sp)
    80003a14:	00913423          	sd	s1,8(sp)
    80003a18:	00113c23          	sd	ra,24(sp)
    80003a1c:	02010413          	addi	s0,sp,32
    80003a20:	00000097          	auipc	ra,0x0
    80003a24:	0c4080e7          	jalr	196(ra) # 80003ae4 <cpuid>
    80003a28:	00004497          	auipc	s1,0x4
    80003a2c:	91848493          	addi	s1,s1,-1768 # 80007340 <started>
    80003a30:	02050263          	beqz	a0,80003a54 <system_main+0x48>
    80003a34:	0004a783          	lw	a5,0(s1)
    80003a38:	0007879b          	sext.w	a5,a5
    80003a3c:	fe078ce3          	beqz	a5,80003a34 <system_main+0x28>
    80003a40:	0ff0000f          	fence
    80003a44:	00002517          	auipc	a0,0x2
    80003a48:	60c50513          	addi	a0,a0,1548 # 80006050 <CONSOLE_STATUS+0x40>
    80003a4c:	00001097          	auipc	ra,0x1
    80003a50:	a70080e7          	jalr	-1424(ra) # 800044bc <panic>
    80003a54:	00001097          	auipc	ra,0x1
    80003a58:	9c4080e7          	jalr	-1596(ra) # 80004418 <consoleinit>
    80003a5c:	00001097          	auipc	ra,0x1
    80003a60:	150080e7          	jalr	336(ra) # 80004bac <printfinit>
    80003a64:	00002517          	auipc	a0,0x2
    80003a68:	6cc50513          	addi	a0,a0,1740 # 80006130 <CONSOLE_STATUS+0x120>
    80003a6c:	00001097          	auipc	ra,0x1
    80003a70:	aac080e7          	jalr	-1364(ra) # 80004518 <__printf>
    80003a74:	00002517          	auipc	a0,0x2
    80003a78:	5ac50513          	addi	a0,a0,1452 # 80006020 <CONSOLE_STATUS+0x10>
    80003a7c:	00001097          	auipc	ra,0x1
    80003a80:	a9c080e7          	jalr	-1380(ra) # 80004518 <__printf>
    80003a84:	00002517          	auipc	a0,0x2
    80003a88:	6ac50513          	addi	a0,a0,1708 # 80006130 <CONSOLE_STATUS+0x120>
    80003a8c:	00001097          	auipc	ra,0x1
    80003a90:	a8c080e7          	jalr	-1396(ra) # 80004518 <__printf>
    80003a94:	00001097          	auipc	ra,0x1
    80003a98:	4a4080e7          	jalr	1188(ra) # 80004f38 <kinit>
    80003a9c:	00000097          	auipc	ra,0x0
    80003aa0:	148080e7          	jalr	328(ra) # 80003be4 <trapinit>
    80003aa4:	00000097          	auipc	ra,0x0
    80003aa8:	16c080e7          	jalr	364(ra) # 80003c10 <trapinithart>
    80003aac:	00000097          	auipc	ra,0x0
    80003ab0:	5b4080e7          	jalr	1460(ra) # 80004060 <plicinit>
    80003ab4:	00000097          	auipc	ra,0x0
    80003ab8:	5d4080e7          	jalr	1492(ra) # 80004088 <plicinithart>
    80003abc:	00000097          	auipc	ra,0x0
    80003ac0:	078080e7          	jalr	120(ra) # 80003b34 <userinit>
    80003ac4:	0ff0000f          	fence
    80003ac8:	00100793          	li	a5,1
    80003acc:	00002517          	auipc	a0,0x2
    80003ad0:	56c50513          	addi	a0,a0,1388 # 80006038 <CONSOLE_STATUS+0x28>
    80003ad4:	00f4a023          	sw	a5,0(s1)
    80003ad8:	00001097          	auipc	ra,0x1
    80003adc:	a40080e7          	jalr	-1472(ra) # 80004518 <__printf>
    80003ae0:	0000006f          	j	80003ae0 <system_main+0xd4>

0000000080003ae4 <cpuid>:
    80003ae4:	ff010113          	addi	sp,sp,-16
    80003ae8:	00813423          	sd	s0,8(sp)
    80003aec:	01010413          	addi	s0,sp,16
    80003af0:	00020513          	mv	a0,tp
    80003af4:	00813403          	ld	s0,8(sp)
    80003af8:	0005051b          	sext.w	a0,a0
    80003afc:	01010113          	addi	sp,sp,16
    80003b00:	00008067          	ret

0000000080003b04 <mycpu>:
    80003b04:	ff010113          	addi	sp,sp,-16
    80003b08:	00813423          	sd	s0,8(sp)
    80003b0c:	01010413          	addi	s0,sp,16
    80003b10:	00020793          	mv	a5,tp
    80003b14:	00813403          	ld	s0,8(sp)
    80003b18:	0007879b          	sext.w	a5,a5
    80003b1c:	00779793          	slli	a5,a5,0x7
    80003b20:	00005517          	auipc	a0,0x5
    80003b24:	b2050513          	addi	a0,a0,-1248 # 80008640 <cpus>
    80003b28:	00f50533          	add	a0,a0,a5
    80003b2c:	01010113          	addi	sp,sp,16
    80003b30:	00008067          	ret

0000000080003b34 <userinit>:
    80003b34:	ff010113          	addi	sp,sp,-16
    80003b38:	00813423          	sd	s0,8(sp)
    80003b3c:	01010413          	addi	s0,sp,16
    80003b40:	00813403          	ld	s0,8(sp)
    80003b44:	01010113          	addi	sp,sp,16
    80003b48:	ffffe317          	auipc	t1,0xffffe
    80003b4c:	29830067          	jr	664(t1) # 80001de0 <main>

0000000080003b50 <either_copyout>:
    80003b50:	ff010113          	addi	sp,sp,-16
    80003b54:	00813023          	sd	s0,0(sp)
    80003b58:	00113423          	sd	ra,8(sp)
    80003b5c:	01010413          	addi	s0,sp,16
    80003b60:	02051663          	bnez	a0,80003b8c <either_copyout+0x3c>
    80003b64:	00058513          	mv	a0,a1
    80003b68:	00060593          	mv	a1,a2
    80003b6c:	0006861b          	sext.w	a2,a3
    80003b70:	00002097          	auipc	ra,0x2
    80003b74:	c54080e7          	jalr	-940(ra) # 800057c4 <__memmove>
    80003b78:	00813083          	ld	ra,8(sp)
    80003b7c:	00013403          	ld	s0,0(sp)
    80003b80:	00000513          	li	a0,0
    80003b84:	01010113          	addi	sp,sp,16
    80003b88:	00008067          	ret
    80003b8c:	00002517          	auipc	a0,0x2
    80003b90:	4ec50513          	addi	a0,a0,1260 # 80006078 <CONSOLE_STATUS+0x68>
    80003b94:	00001097          	auipc	ra,0x1
    80003b98:	928080e7          	jalr	-1752(ra) # 800044bc <panic>

0000000080003b9c <either_copyin>:
    80003b9c:	ff010113          	addi	sp,sp,-16
    80003ba0:	00813023          	sd	s0,0(sp)
    80003ba4:	00113423          	sd	ra,8(sp)
    80003ba8:	01010413          	addi	s0,sp,16
    80003bac:	02059463          	bnez	a1,80003bd4 <either_copyin+0x38>
    80003bb0:	00060593          	mv	a1,a2
    80003bb4:	0006861b          	sext.w	a2,a3
    80003bb8:	00002097          	auipc	ra,0x2
    80003bbc:	c0c080e7          	jalr	-1012(ra) # 800057c4 <__memmove>
    80003bc0:	00813083          	ld	ra,8(sp)
    80003bc4:	00013403          	ld	s0,0(sp)
    80003bc8:	00000513          	li	a0,0
    80003bcc:	01010113          	addi	sp,sp,16
    80003bd0:	00008067          	ret
    80003bd4:	00002517          	auipc	a0,0x2
    80003bd8:	4cc50513          	addi	a0,a0,1228 # 800060a0 <CONSOLE_STATUS+0x90>
    80003bdc:	00001097          	auipc	ra,0x1
    80003be0:	8e0080e7          	jalr	-1824(ra) # 800044bc <panic>

0000000080003be4 <trapinit>:
    80003be4:	ff010113          	addi	sp,sp,-16
    80003be8:	00813423          	sd	s0,8(sp)
    80003bec:	01010413          	addi	s0,sp,16
    80003bf0:	00813403          	ld	s0,8(sp)
    80003bf4:	00002597          	auipc	a1,0x2
    80003bf8:	4d458593          	addi	a1,a1,1236 # 800060c8 <CONSOLE_STATUS+0xb8>
    80003bfc:	00005517          	auipc	a0,0x5
    80003c00:	ac450513          	addi	a0,a0,-1340 # 800086c0 <tickslock>
    80003c04:	01010113          	addi	sp,sp,16
    80003c08:	00001317          	auipc	t1,0x1
    80003c0c:	5c030067          	jr	1472(t1) # 800051c8 <initlock>

0000000080003c10 <trapinithart>:
    80003c10:	ff010113          	addi	sp,sp,-16
    80003c14:	00813423          	sd	s0,8(sp)
    80003c18:	01010413          	addi	s0,sp,16
    80003c1c:	00000797          	auipc	a5,0x0
    80003c20:	2f478793          	addi	a5,a5,756 # 80003f10 <kernelvec>
    80003c24:	10579073          	csrw	stvec,a5
    80003c28:	00813403          	ld	s0,8(sp)
    80003c2c:	01010113          	addi	sp,sp,16
    80003c30:	00008067          	ret

0000000080003c34 <usertrap>:
    80003c34:	ff010113          	addi	sp,sp,-16
    80003c38:	00813423          	sd	s0,8(sp)
    80003c3c:	01010413          	addi	s0,sp,16
    80003c40:	00813403          	ld	s0,8(sp)
    80003c44:	01010113          	addi	sp,sp,16
    80003c48:	00008067          	ret

0000000080003c4c <usertrapret>:
    80003c4c:	ff010113          	addi	sp,sp,-16
    80003c50:	00813423          	sd	s0,8(sp)
    80003c54:	01010413          	addi	s0,sp,16
    80003c58:	00813403          	ld	s0,8(sp)
    80003c5c:	01010113          	addi	sp,sp,16
    80003c60:	00008067          	ret

0000000080003c64 <kerneltrap>:
    80003c64:	fe010113          	addi	sp,sp,-32
    80003c68:	00813823          	sd	s0,16(sp)
    80003c6c:	00113c23          	sd	ra,24(sp)
    80003c70:	00913423          	sd	s1,8(sp)
    80003c74:	02010413          	addi	s0,sp,32
    80003c78:	142025f3          	csrr	a1,scause
    80003c7c:	100027f3          	csrr	a5,sstatus
    80003c80:	0027f793          	andi	a5,a5,2
    80003c84:	10079c63          	bnez	a5,80003d9c <kerneltrap+0x138>
    80003c88:	142027f3          	csrr	a5,scause
    80003c8c:	0207ce63          	bltz	a5,80003cc8 <kerneltrap+0x64>
    80003c90:	00002517          	auipc	a0,0x2
    80003c94:	48050513          	addi	a0,a0,1152 # 80006110 <CONSOLE_STATUS+0x100>
    80003c98:	00001097          	auipc	ra,0x1
    80003c9c:	880080e7          	jalr	-1920(ra) # 80004518 <__printf>
    80003ca0:	141025f3          	csrr	a1,sepc
    80003ca4:	14302673          	csrr	a2,stval
    80003ca8:	00002517          	auipc	a0,0x2
    80003cac:	47850513          	addi	a0,a0,1144 # 80006120 <CONSOLE_STATUS+0x110>
    80003cb0:	00001097          	auipc	ra,0x1
    80003cb4:	868080e7          	jalr	-1944(ra) # 80004518 <__printf>
    80003cb8:	00002517          	auipc	a0,0x2
    80003cbc:	48050513          	addi	a0,a0,1152 # 80006138 <CONSOLE_STATUS+0x128>
    80003cc0:	00000097          	auipc	ra,0x0
    80003cc4:	7fc080e7          	jalr	2044(ra) # 800044bc <panic>
    80003cc8:	0ff7f713          	andi	a4,a5,255
    80003ccc:	00900693          	li	a3,9
    80003cd0:	04d70063          	beq	a4,a3,80003d10 <kerneltrap+0xac>
    80003cd4:	fff00713          	li	a4,-1
    80003cd8:	03f71713          	slli	a4,a4,0x3f
    80003cdc:	00170713          	addi	a4,a4,1
    80003ce0:	fae798e3          	bne	a5,a4,80003c90 <kerneltrap+0x2c>
    80003ce4:	00000097          	auipc	ra,0x0
    80003ce8:	e00080e7          	jalr	-512(ra) # 80003ae4 <cpuid>
    80003cec:	06050663          	beqz	a0,80003d58 <kerneltrap+0xf4>
    80003cf0:	144027f3          	csrr	a5,sip
    80003cf4:	ffd7f793          	andi	a5,a5,-3
    80003cf8:	14479073          	csrw	sip,a5
    80003cfc:	01813083          	ld	ra,24(sp)
    80003d00:	01013403          	ld	s0,16(sp)
    80003d04:	00813483          	ld	s1,8(sp)
    80003d08:	02010113          	addi	sp,sp,32
    80003d0c:	00008067          	ret
    80003d10:	00000097          	auipc	ra,0x0
    80003d14:	3c4080e7          	jalr	964(ra) # 800040d4 <plic_claim>
    80003d18:	00a00793          	li	a5,10
    80003d1c:	00050493          	mv	s1,a0
    80003d20:	06f50863          	beq	a0,a5,80003d90 <kerneltrap+0x12c>
    80003d24:	fc050ce3          	beqz	a0,80003cfc <kerneltrap+0x98>
    80003d28:	00050593          	mv	a1,a0
    80003d2c:	00002517          	auipc	a0,0x2
    80003d30:	3c450513          	addi	a0,a0,964 # 800060f0 <CONSOLE_STATUS+0xe0>
    80003d34:	00000097          	auipc	ra,0x0
    80003d38:	7e4080e7          	jalr	2020(ra) # 80004518 <__printf>
    80003d3c:	01013403          	ld	s0,16(sp)
    80003d40:	01813083          	ld	ra,24(sp)
    80003d44:	00048513          	mv	a0,s1
    80003d48:	00813483          	ld	s1,8(sp)
    80003d4c:	02010113          	addi	sp,sp,32
    80003d50:	00000317          	auipc	t1,0x0
    80003d54:	3bc30067          	jr	956(t1) # 8000410c <plic_complete>
    80003d58:	00005517          	auipc	a0,0x5
    80003d5c:	96850513          	addi	a0,a0,-1688 # 800086c0 <tickslock>
    80003d60:	00001097          	auipc	ra,0x1
    80003d64:	48c080e7          	jalr	1164(ra) # 800051ec <acquire>
    80003d68:	00003717          	auipc	a4,0x3
    80003d6c:	5dc70713          	addi	a4,a4,1500 # 80007344 <ticks>
    80003d70:	00072783          	lw	a5,0(a4)
    80003d74:	00005517          	auipc	a0,0x5
    80003d78:	94c50513          	addi	a0,a0,-1716 # 800086c0 <tickslock>
    80003d7c:	0017879b          	addiw	a5,a5,1
    80003d80:	00f72023          	sw	a5,0(a4)
    80003d84:	00001097          	auipc	ra,0x1
    80003d88:	534080e7          	jalr	1332(ra) # 800052b8 <release>
    80003d8c:	f65ff06f          	j	80003cf0 <kerneltrap+0x8c>
    80003d90:	00001097          	auipc	ra,0x1
    80003d94:	090080e7          	jalr	144(ra) # 80004e20 <uartintr>
    80003d98:	fa5ff06f          	j	80003d3c <kerneltrap+0xd8>
    80003d9c:	00002517          	auipc	a0,0x2
    80003da0:	33450513          	addi	a0,a0,820 # 800060d0 <CONSOLE_STATUS+0xc0>
    80003da4:	00000097          	auipc	ra,0x0
    80003da8:	718080e7          	jalr	1816(ra) # 800044bc <panic>

0000000080003dac <clockintr>:
    80003dac:	fe010113          	addi	sp,sp,-32
    80003db0:	00813823          	sd	s0,16(sp)
    80003db4:	00913423          	sd	s1,8(sp)
    80003db8:	00113c23          	sd	ra,24(sp)
    80003dbc:	02010413          	addi	s0,sp,32
    80003dc0:	00005497          	auipc	s1,0x5
    80003dc4:	90048493          	addi	s1,s1,-1792 # 800086c0 <tickslock>
    80003dc8:	00048513          	mv	a0,s1
    80003dcc:	00001097          	auipc	ra,0x1
    80003dd0:	420080e7          	jalr	1056(ra) # 800051ec <acquire>
    80003dd4:	00003717          	auipc	a4,0x3
    80003dd8:	57070713          	addi	a4,a4,1392 # 80007344 <ticks>
    80003ddc:	00072783          	lw	a5,0(a4)
    80003de0:	01013403          	ld	s0,16(sp)
    80003de4:	01813083          	ld	ra,24(sp)
    80003de8:	00048513          	mv	a0,s1
    80003dec:	0017879b          	addiw	a5,a5,1
    80003df0:	00813483          	ld	s1,8(sp)
    80003df4:	00f72023          	sw	a5,0(a4)
    80003df8:	02010113          	addi	sp,sp,32
    80003dfc:	00001317          	auipc	t1,0x1
    80003e00:	4bc30067          	jr	1212(t1) # 800052b8 <release>

0000000080003e04 <devintr>:
    80003e04:	142027f3          	csrr	a5,scause
    80003e08:	00000513          	li	a0,0
    80003e0c:	0007c463          	bltz	a5,80003e14 <devintr+0x10>
    80003e10:	00008067          	ret
    80003e14:	fe010113          	addi	sp,sp,-32
    80003e18:	00813823          	sd	s0,16(sp)
    80003e1c:	00113c23          	sd	ra,24(sp)
    80003e20:	00913423          	sd	s1,8(sp)
    80003e24:	02010413          	addi	s0,sp,32
    80003e28:	0ff7f713          	andi	a4,a5,255
    80003e2c:	00900693          	li	a3,9
    80003e30:	04d70c63          	beq	a4,a3,80003e88 <devintr+0x84>
    80003e34:	fff00713          	li	a4,-1
    80003e38:	03f71713          	slli	a4,a4,0x3f
    80003e3c:	00170713          	addi	a4,a4,1
    80003e40:	00e78c63          	beq	a5,a4,80003e58 <devintr+0x54>
    80003e44:	01813083          	ld	ra,24(sp)
    80003e48:	01013403          	ld	s0,16(sp)
    80003e4c:	00813483          	ld	s1,8(sp)
    80003e50:	02010113          	addi	sp,sp,32
    80003e54:	00008067          	ret
    80003e58:	00000097          	auipc	ra,0x0
    80003e5c:	c8c080e7          	jalr	-884(ra) # 80003ae4 <cpuid>
    80003e60:	06050663          	beqz	a0,80003ecc <devintr+0xc8>
    80003e64:	144027f3          	csrr	a5,sip
    80003e68:	ffd7f793          	andi	a5,a5,-3
    80003e6c:	14479073          	csrw	sip,a5
    80003e70:	01813083          	ld	ra,24(sp)
    80003e74:	01013403          	ld	s0,16(sp)
    80003e78:	00813483          	ld	s1,8(sp)
    80003e7c:	00200513          	li	a0,2
    80003e80:	02010113          	addi	sp,sp,32
    80003e84:	00008067          	ret
    80003e88:	00000097          	auipc	ra,0x0
    80003e8c:	24c080e7          	jalr	588(ra) # 800040d4 <plic_claim>
    80003e90:	00a00793          	li	a5,10
    80003e94:	00050493          	mv	s1,a0
    80003e98:	06f50663          	beq	a0,a5,80003f04 <devintr+0x100>
    80003e9c:	00100513          	li	a0,1
    80003ea0:	fa0482e3          	beqz	s1,80003e44 <devintr+0x40>
    80003ea4:	00048593          	mv	a1,s1
    80003ea8:	00002517          	auipc	a0,0x2
    80003eac:	24850513          	addi	a0,a0,584 # 800060f0 <CONSOLE_STATUS+0xe0>
    80003eb0:	00000097          	auipc	ra,0x0
    80003eb4:	668080e7          	jalr	1640(ra) # 80004518 <__printf>
    80003eb8:	00048513          	mv	a0,s1
    80003ebc:	00000097          	auipc	ra,0x0
    80003ec0:	250080e7          	jalr	592(ra) # 8000410c <plic_complete>
    80003ec4:	00100513          	li	a0,1
    80003ec8:	f7dff06f          	j	80003e44 <devintr+0x40>
    80003ecc:	00004517          	auipc	a0,0x4
    80003ed0:	7f450513          	addi	a0,a0,2036 # 800086c0 <tickslock>
    80003ed4:	00001097          	auipc	ra,0x1
    80003ed8:	318080e7          	jalr	792(ra) # 800051ec <acquire>
    80003edc:	00003717          	auipc	a4,0x3
    80003ee0:	46870713          	addi	a4,a4,1128 # 80007344 <ticks>
    80003ee4:	00072783          	lw	a5,0(a4)
    80003ee8:	00004517          	auipc	a0,0x4
    80003eec:	7d850513          	addi	a0,a0,2008 # 800086c0 <tickslock>
    80003ef0:	0017879b          	addiw	a5,a5,1
    80003ef4:	00f72023          	sw	a5,0(a4)
    80003ef8:	00001097          	auipc	ra,0x1
    80003efc:	3c0080e7          	jalr	960(ra) # 800052b8 <release>
    80003f00:	f65ff06f          	j	80003e64 <devintr+0x60>
    80003f04:	00001097          	auipc	ra,0x1
    80003f08:	f1c080e7          	jalr	-228(ra) # 80004e20 <uartintr>
    80003f0c:	fadff06f          	j	80003eb8 <devintr+0xb4>

0000000080003f10 <kernelvec>:
    80003f10:	f0010113          	addi	sp,sp,-256
    80003f14:	00113023          	sd	ra,0(sp)
    80003f18:	00213423          	sd	sp,8(sp)
    80003f1c:	00313823          	sd	gp,16(sp)
    80003f20:	00413c23          	sd	tp,24(sp)
    80003f24:	02513023          	sd	t0,32(sp)
    80003f28:	02613423          	sd	t1,40(sp)
    80003f2c:	02713823          	sd	t2,48(sp)
    80003f30:	02813c23          	sd	s0,56(sp)
    80003f34:	04913023          	sd	s1,64(sp)
    80003f38:	04a13423          	sd	a0,72(sp)
    80003f3c:	04b13823          	sd	a1,80(sp)
    80003f40:	04c13c23          	sd	a2,88(sp)
    80003f44:	06d13023          	sd	a3,96(sp)
    80003f48:	06e13423          	sd	a4,104(sp)
    80003f4c:	06f13823          	sd	a5,112(sp)
    80003f50:	07013c23          	sd	a6,120(sp)
    80003f54:	09113023          	sd	a7,128(sp)
    80003f58:	09213423          	sd	s2,136(sp)
    80003f5c:	09313823          	sd	s3,144(sp)
    80003f60:	09413c23          	sd	s4,152(sp)
    80003f64:	0b513023          	sd	s5,160(sp)
    80003f68:	0b613423          	sd	s6,168(sp)
    80003f6c:	0b713823          	sd	s7,176(sp)
    80003f70:	0b813c23          	sd	s8,184(sp)
    80003f74:	0d913023          	sd	s9,192(sp)
    80003f78:	0da13423          	sd	s10,200(sp)
    80003f7c:	0db13823          	sd	s11,208(sp)
    80003f80:	0dc13c23          	sd	t3,216(sp)
    80003f84:	0fd13023          	sd	t4,224(sp)
    80003f88:	0fe13423          	sd	t5,232(sp)
    80003f8c:	0ff13823          	sd	t6,240(sp)
    80003f90:	cd5ff0ef          	jal	ra,80003c64 <kerneltrap>
    80003f94:	00013083          	ld	ra,0(sp)
    80003f98:	00813103          	ld	sp,8(sp)
    80003f9c:	01013183          	ld	gp,16(sp)
    80003fa0:	02013283          	ld	t0,32(sp)
    80003fa4:	02813303          	ld	t1,40(sp)
    80003fa8:	03013383          	ld	t2,48(sp)
    80003fac:	03813403          	ld	s0,56(sp)
    80003fb0:	04013483          	ld	s1,64(sp)
    80003fb4:	04813503          	ld	a0,72(sp)
    80003fb8:	05013583          	ld	a1,80(sp)
    80003fbc:	05813603          	ld	a2,88(sp)
    80003fc0:	06013683          	ld	a3,96(sp)
    80003fc4:	06813703          	ld	a4,104(sp)
    80003fc8:	07013783          	ld	a5,112(sp)
    80003fcc:	07813803          	ld	a6,120(sp)
    80003fd0:	08013883          	ld	a7,128(sp)
    80003fd4:	08813903          	ld	s2,136(sp)
    80003fd8:	09013983          	ld	s3,144(sp)
    80003fdc:	09813a03          	ld	s4,152(sp)
    80003fe0:	0a013a83          	ld	s5,160(sp)
    80003fe4:	0a813b03          	ld	s6,168(sp)
    80003fe8:	0b013b83          	ld	s7,176(sp)
    80003fec:	0b813c03          	ld	s8,184(sp)
    80003ff0:	0c013c83          	ld	s9,192(sp)
    80003ff4:	0c813d03          	ld	s10,200(sp)
    80003ff8:	0d013d83          	ld	s11,208(sp)
    80003ffc:	0d813e03          	ld	t3,216(sp)
    80004000:	0e013e83          	ld	t4,224(sp)
    80004004:	0e813f03          	ld	t5,232(sp)
    80004008:	0f013f83          	ld	t6,240(sp)
    8000400c:	10010113          	addi	sp,sp,256
    80004010:	10200073          	sret
    80004014:	00000013          	nop
    80004018:	00000013          	nop
    8000401c:	00000013          	nop

0000000080004020 <timervec>:
    80004020:	34051573          	csrrw	a0,mscratch,a0
    80004024:	00b53023          	sd	a1,0(a0)
    80004028:	00c53423          	sd	a2,8(a0)
    8000402c:	00d53823          	sd	a3,16(a0)
    80004030:	01853583          	ld	a1,24(a0)
    80004034:	02053603          	ld	a2,32(a0)
    80004038:	0005b683          	ld	a3,0(a1)
    8000403c:	00c686b3          	add	a3,a3,a2
    80004040:	00d5b023          	sd	a3,0(a1)
    80004044:	00200593          	li	a1,2
    80004048:	14459073          	csrw	sip,a1
    8000404c:	01053683          	ld	a3,16(a0)
    80004050:	00853603          	ld	a2,8(a0)
    80004054:	00053583          	ld	a1,0(a0)
    80004058:	34051573          	csrrw	a0,mscratch,a0
    8000405c:	30200073          	mret

0000000080004060 <plicinit>:
    80004060:	ff010113          	addi	sp,sp,-16
    80004064:	00813423          	sd	s0,8(sp)
    80004068:	01010413          	addi	s0,sp,16
    8000406c:	00813403          	ld	s0,8(sp)
    80004070:	0c0007b7          	lui	a5,0xc000
    80004074:	00100713          	li	a4,1
    80004078:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    8000407c:	00e7a223          	sw	a4,4(a5)
    80004080:	01010113          	addi	sp,sp,16
    80004084:	00008067          	ret

0000000080004088 <plicinithart>:
    80004088:	ff010113          	addi	sp,sp,-16
    8000408c:	00813023          	sd	s0,0(sp)
    80004090:	00113423          	sd	ra,8(sp)
    80004094:	01010413          	addi	s0,sp,16
    80004098:	00000097          	auipc	ra,0x0
    8000409c:	a4c080e7          	jalr	-1460(ra) # 80003ae4 <cpuid>
    800040a0:	0085171b          	slliw	a4,a0,0x8
    800040a4:	0c0027b7          	lui	a5,0xc002
    800040a8:	00e787b3          	add	a5,a5,a4
    800040ac:	40200713          	li	a4,1026
    800040b0:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    800040b4:	00813083          	ld	ra,8(sp)
    800040b8:	00013403          	ld	s0,0(sp)
    800040bc:	00d5151b          	slliw	a0,a0,0xd
    800040c0:	0c2017b7          	lui	a5,0xc201
    800040c4:	00a78533          	add	a0,a5,a0
    800040c8:	00052023          	sw	zero,0(a0)
    800040cc:	01010113          	addi	sp,sp,16
    800040d0:	00008067          	ret

00000000800040d4 <plic_claim>:
    800040d4:	ff010113          	addi	sp,sp,-16
    800040d8:	00813023          	sd	s0,0(sp)
    800040dc:	00113423          	sd	ra,8(sp)
    800040e0:	01010413          	addi	s0,sp,16
    800040e4:	00000097          	auipc	ra,0x0
    800040e8:	a00080e7          	jalr	-1536(ra) # 80003ae4 <cpuid>
    800040ec:	00813083          	ld	ra,8(sp)
    800040f0:	00013403          	ld	s0,0(sp)
    800040f4:	00d5151b          	slliw	a0,a0,0xd
    800040f8:	0c2017b7          	lui	a5,0xc201
    800040fc:	00a78533          	add	a0,a5,a0
    80004100:	00452503          	lw	a0,4(a0)
    80004104:	01010113          	addi	sp,sp,16
    80004108:	00008067          	ret

000000008000410c <plic_complete>:
    8000410c:	fe010113          	addi	sp,sp,-32
    80004110:	00813823          	sd	s0,16(sp)
    80004114:	00913423          	sd	s1,8(sp)
    80004118:	00113c23          	sd	ra,24(sp)
    8000411c:	02010413          	addi	s0,sp,32
    80004120:	00050493          	mv	s1,a0
    80004124:	00000097          	auipc	ra,0x0
    80004128:	9c0080e7          	jalr	-1600(ra) # 80003ae4 <cpuid>
    8000412c:	01813083          	ld	ra,24(sp)
    80004130:	01013403          	ld	s0,16(sp)
    80004134:	00d5179b          	slliw	a5,a0,0xd
    80004138:	0c201737          	lui	a4,0xc201
    8000413c:	00f707b3          	add	a5,a4,a5
    80004140:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80004144:	00813483          	ld	s1,8(sp)
    80004148:	02010113          	addi	sp,sp,32
    8000414c:	00008067          	ret

0000000080004150 <consolewrite>:
    80004150:	fb010113          	addi	sp,sp,-80
    80004154:	04813023          	sd	s0,64(sp)
    80004158:	04113423          	sd	ra,72(sp)
    8000415c:	02913c23          	sd	s1,56(sp)
    80004160:	03213823          	sd	s2,48(sp)
    80004164:	03313423          	sd	s3,40(sp)
    80004168:	03413023          	sd	s4,32(sp)
    8000416c:	01513c23          	sd	s5,24(sp)
    80004170:	05010413          	addi	s0,sp,80
    80004174:	06c05c63          	blez	a2,800041ec <consolewrite+0x9c>
    80004178:	00060993          	mv	s3,a2
    8000417c:	00050a13          	mv	s4,a0
    80004180:	00058493          	mv	s1,a1
    80004184:	00000913          	li	s2,0
    80004188:	fff00a93          	li	s5,-1
    8000418c:	01c0006f          	j	800041a8 <consolewrite+0x58>
    80004190:	fbf44503          	lbu	a0,-65(s0)
    80004194:	0019091b          	addiw	s2,s2,1
    80004198:	00148493          	addi	s1,s1,1
    8000419c:	00001097          	auipc	ra,0x1
    800041a0:	a9c080e7          	jalr	-1380(ra) # 80004c38 <uartputc>
    800041a4:	03298063          	beq	s3,s2,800041c4 <consolewrite+0x74>
    800041a8:	00048613          	mv	a2,s1
    800041ac:	00100693          	li	a3,1
    800041b0:	000a0593          	mv	a1,s4
    800041b4:	fbf40513          	addi	a0,s0,-65
    800041b8:	00000097          	auipc	ra,0x0
    800041bc:	9e4080e7          	jalr	-1564(ra) # 80003b9c <either_copyin>
    800041c0:	fd5518e3          	bne	a0,s5,80004190 <consolewrite+0x40>
    800041c4:	04813083          	ld	ra,72(sp)
    800041c8:	04013403          	ld	s0,64(sp)
    800041cc:	03813483          	ld	s1,56(sp)
    800041d0:	02813983          	ld	s3,40(sp)
    800041d4:	02013a03          	ld	s4,32(sp)
    800041d8:	01813a83          	ld	s5,24(sp)
    800041dc:	00090513          	mv	a0,s2
    800041e0:	03013903          	ld	s2,48(sp)
    800041e4:	05010113          	addi	sp,sp,80
    800041e8:	00008067          	ret
    800041ec:	00000913          	li	s2,0
    800041f0:	fd5ff06f          	j	800041c4 <consolewrite+0x74>

00000000800041f4 <consoleread>:
    800041f4:	f9010113          	addi	sp,sp,-112
    800041f8:	06813023          	sd	s0,96(sp)
    800041fc:	04913c23          	sd	s1,88(sp)
    80004200:	05213823          	sd	s2,80(sp)
    80004204:	05313423          	sd	s3,72(sp)
    80004208:	05413023          	sd	s4,64(sp)
    8000420c:	03513c23          	sd	s5,56(sp)
    80004210:	03613823          	sd	s6,48(sp)
    80004214:	03713423          	sd	s7,40(sp)
    80004218:	03813023          	sd	s8,32(sp)
    8000421c:	06113423          	sd	ra,104(sp)
    80004220:	01913c23          	sd	s9,24(sp)
    80004224:	07010413          	addi	s0,sp,112
    80004228:	00060b93          	mv	s7,a2
    8000422c:	00050913          	mv	s2,a0
    80004230:	00058c13          	mv	s8,a1
    80004234:	00060b1b          	sext.w	s6,a2
    80004238:	00004497          	auipc	s1,0x4
    8000423c:	4a048493          	addi	s1,s1,1184 # 800086d8 <cons>
    80004240:	00400993          	li	s3,4
    80004244:	fff00a13          	li	s4,-1
    80004248:	00a00a93          	li	s5,10
    8000424c:	05705e63          	blez	s7,800042a8 <consoleread+0xb4>
    80004250:	09c4a703          	lw	a4,156(s1)
    80004254:	0984a783          	lw	a5,152(s1)
    80004258:	0007071b          	sext.w	a4,a4
    8000425c:	08e78463          	beq	a5,a4,800042e4 <consoleread+0xf0>
    80004260:	07f7f713          	andi	a4,a5,127
    80004264:	00e48733          	add	a4,s1,a4
    80004268:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    8000426c:	0017869b          	addiw	a3,a5,1
    80004270:	08d4ac23          	sw	a3,152(s1)
    80004274:	00070c9b          	sext.w	s9,a4
    80004278:	0b370663          	beq	a4,s3,80004324 <consoleread+0x130>
    8000427c:	00100693          	li	a3,1
    80004280:	f9f40613          	addi	a2,s0,-97
    80004284:	000c0593          	mv	a1,s8
    80004288:	00090513          	mv	a0,s2
    8000428c:	f8e40fa3          	sb	a4,-97(s0)
    80004290:	00000097          	auipc	ra,0x0
    80004294:	8c0080e7          	jalr	-1856(ra) # 80003b50 <either_copyout>
    80004298:	01450863          	beq	a0,s4,800042a8 <consoleread+0xb4>
    8000429c:	001c0c13          	addi	s8,s8,1
    800042a0:	fffb8b9b          	addiw	s7,s7,-1
    800042a4:	fb5c94e3          	bne	s9,s5,8000424c <consoleread+0x58>
    800042a8:	000b851b          	sext.w	a0,s7
    800042ac:	06813083          	ld	ra,104(sp)
    800042b0:	06013403          	ld	s0,96(sp)
    800042b4:	05813483          	ld	s1,88(sp)
    800042b8:	05013903          	ld	s2,80(sp)
    800042bc:	04813983          	ld	s3,72(sp)
    800042c0:	04013a03          	ld	s4,64(sp)
    800042c4:	03813a83          	ld	s5,56(sp)
    800042c8:	02813b83          	ld	s7,40(sp)
    800042cc:	02013c03          	ld	s8,32(sp)
    800042d0:	01813c83          	ld	s9,24(sp)
    800042d4:	40ab053b          	subw	a0,s6,a0
    800042d8:	03013b03          	ld	s6,48(sp)
    800042dc:	07010113          	addi	sp,sp,112
    800042e0:	00008067          	ret
    800042e4:	00001097          	auipc	ra,0x1
    800042e8:	1d8080e7          	jalr	472(ra) # 800054bc <push_on>
    800042ec:	0984a703          	lw	a4,152(s1)
    800042f0:	09c4a783          	lw	a5,156(s1)
    800042f4:	0007879b          	sext.w	a5,a5
    800042f8:	fef70ce3          	beq	a4,a5,800042f0 <consoleread+0xfc>
    800042fc:	00001097          	auipc	ra,0x1
    80004300:	234080e7          	jalr	564(ra) # 80005530 <pop_on>
    80004304:	0984a783          	lw	a5,152(s1)
    80004308:	07f7f713          	andi	a4,a5,127
    8000430c:	00e48733          	add	a4,s1,a4
    80004310:	01874703          	lbu	a4,24(a4)
    80004314:	0017869b          	addiw	a3,a5,1
    80004318:	08d4ac23          	sw	a3,152(s1)
    8000431c:	00070c9b          	sext.w	s9,a4
    80004320:	f5371ee3          	bne	a4,s3,8000427c <consoleread+0x88>
    80004324:	000b851b          	sext.w	a0,s7
    80004328:	f96bf2e3          	bgeu	s7,s6,800042ac <consoleread+0xb8>
    8000432c:	08f4ac23          	sw	a5,152(s1)
    80004330:	f7dff06f          	j	800042ac <consoleread+0xb8>

0000000080004334 <consputc>:
    80004334:	10000793          	li	a5,256
    80004338:	00f50663          	beq	a0,a5,80004344 <consputc+0x10>
    8000433c:	00001317          	auipc	t1,0x1
    80004340:	9f430067          	jr	-1548(t1) # 80004d30 <uartputc_sync>
    80004344:	ff010113          	addi	sp,sp,-16
    80004348:	00113423          	sd	ra,8(sp)
    8000434c:	00813023          	sd	s0,0(sp)
    80004350:	01010413          	addi	s0,sp,16
    80004354:	00800513          	li	a0,8
    80004358:	00001097          	auipc	ra,0x1
    8000435c:	9d8080e7          	jalr	-1576(ra) # 80004d30 <uartputc_sync>
    80004360:	02000513          	li	a0,32
    80004364:	00001097          	auipc	ra,0x1
    80004368:	9cc080e7          	jalr	-1588(ra) # 80004d30 <uartputc_sync>
    8000436c:	00013403          	ld	s0,0(sp)
    80004370:	00813083          	ld	ra,8(sp)
    80004374:	00800513          	li	a0,8
    80004378:	01010113          	addi	sp,sp,16
    8000437c:	00001317          	auipc	t1,0x1
    80004380:	9b430067          	jr	-1612(t1) # 80004d30 <uartputc_sync>

0000000080004384 <consoleintr>:
    80004384:	fe010113          	addi	sp,sp,-32
    80004388:	00813823          	sd	s0,16(sp)
    8000438c:	00913423          	sd	s1,8(sp)
    80004390:	01213023          	sd	s2,0(sp)
    80004394:	00113c23          	sd	ra,24(sp)
    80004398:	02010413          	addi	s0,sp,32
    8000439c:	00004917          	auipc	s2,0x4
    800043a0:	33c90913          	addi	s2,s2,828 # 800086d8 <cons>
    800043a4:	00050493          	mv	s1,a0
    800043a8:	00090513          	mv	a0,s2
    800043ac:	00001097          	auipc	ra,0x1
    800043b0:	e40080e7          	jalr	-448(ra) # 800051ec <acquire>
    800043b4:	02048c63          	beqz	s1,800043ec <consoleintr+0x68>
    800043b8:	0a092783          	lw	a5,160(s2)
    800043bc:	09892703          	lw	a4,152(s2)
    800043c0:	07f00693          	li	a3,127
    800043c4:	40e7873b          	subw	a4,a5,a4
    800043c8:	02e6e263          	bltu	a3,a4,800043ec <consoleintr+0x68>
    800043cc:	00d00713          	li	a4,13
    800043d0:	04e48063          	beq	s1,a4,80004410 <consoleintr+0x8c>
    800043d4:	07f7f713          	andi	a4,a5,127
    800043d8:	00e90733          	add	a4,s2,a4
    800043dc:	0017879b          	addiw	a5,a5,1
    800043e0:	0af92023          	sw	a5,160(s2)
    800043e4:	00970c23          	sb	s1,24(a4)
    800043e8:	08f92e23          	sw	a5,156(s2)
    800043ec:	01013403          	ld	s0,16(sp)
    800043f0:	01813083          	ld	ra,24(sp)
    800043f4:	00813483          	ld	s1,8(sp)
    800043f8:	00013903          	ld	s2,0(sp)
    800043fc:	00004517          	auipc	a0,0x4
    80004400:	2dc50513          	addi	a0,a0,732 # 800086d8 <cons>
    80004404:	02010113          	addi	sp,sp,32
    80004408:	00001317          	auipc	t1,0x1
    8000440c:	eb030067          	jr	-336(t1) # 800052b8 <release>
    80004410:	00a00493          	li	s1,10
    80004414:	fc1ff06f          	j	800043d4 <consoleintr+0x50>

0000000080004418 <consoleinit>:
    80004418:	fe010113          	addi	sp,sp,-32
    8000441c:	00113c23          	sd	ra,24(sp)
    80004420:	00813823          	sd	s0,16(sp)
    80004424:	00913423          	sd	s1,8(sp)
    80004428:	02010413          	addi	s0,sp,32
    8000442c:	00004497          	auipc	s1,0x4
    80004430:	2ac48493          	addi	s1,s1,684 # 800086d8 <cons>
    80004434:	00048513          	mv	a0,s1
    80004438:	00002597          	auipc	a1,0x2
    8000443c:	d1058593          	addi	a1,a1,-752 # 80006148 <CONSOLE_STATUS+0x138>
    80004440:	00001097          	auipc	ra,0x1
    80004444:	d88080e7          	jalr	-632(ra) # 800051c8 <initlock>
    80004448:	00000097          	auipc	ra,0x0
    8000444c:	7ac080e7          	jalr	1964(ra) # 80004bf4 <uartinit>
    80004450:	01813083          	ld	ra,24(sp)
    80004454:	01013403          	ld	s0,16(sp)
    80004458:	00000797          	auipc	a5,0x0
    8000445c:	d9c78793          	addi	a5,a5,-612 # 800041f4 <consoleread>
    80004460:	0af4bc23          	sd	a5,184(s1)
    80004464:	00000797          	auipc	a5,0x0
    80004468:	cec78793          	addi	a5,a5,-788 # 80004150 <consolewrite>
    8000446c:	0cf4b023          	sd	a5,192(s1)
    80004470:	00813483          	ld	s1,8(sp)
    80004474:	02010113          	addi	sp,sp,32
    80004478:	00008067          	ret

000000008000447c <console_read>:
    8000447c:	ff010113          	addi	sp,sp,-16
    80004480:	00813423          	sd	s0,8(sp)
    80004484:	01010413          	addi	s0,sp,16
    80004488:	00813403          	ld	s0,8(sp)
    8000448c:	00004317          	auipc	t1,0x4
    80004490:	30433303          	ld	t1,772(t1) # 80008790 <devsw+0x10>
    80004494:	01010113          	addi	sp,sp,16
    80004498:	00030067          	jr	t1

000000008000449c <console_write>:
    8000449c:	ff010113          	addi	sp,sp,-16
    800044a0:	00813423          	sd	s0,8(sp)
    800044a4:	01010413          	addi	s0,sp,16
    800044a8:	00813403          	ld	s0,8(sp)
    800044ac:	00004317          	auipc	t1,0x4
    800044b0:	2ec33303          	ld	t1,748(t1) # 80008798 <devsw+0x18>
    800044b4:	01010113          	addi	sp,sp,16
    800044b8:	00030067          	jr	t1

00000000800044bc <panic>:
    800044bc:	fe010113          	addi	sp,sp,-32
    800044c0:	00113c23          	sd	ra,24(sp)
    800044c4:	00813823          	sd	s0,16(sp)
    800044c8:	00913423          	sd	s1,8(sp)
    800044cc:	02010413          	addi	s0,sp,32
    800044d0:	00050493          	mv	s1,a0
    800044d4:	00002517          	auipc	a0,0x2
    800044d8:	c7c50513          	addi	a0,a0,-900 # 80006150 <CONSOLE_STATUS+0x140>
    800044dc:	00004797          	auipc	a5,0x4
    800044e0:	3407ae23          	sw	zero,860(a5) # 80008838 <pr+0x18>
    800044e4:	00000097          	auipc	ra,0x0
    800044e8:	034080e7          	jalr	52(ra) # 80004518 <__printf>
    800044ec:	00048513          	mv	a0,s1
    800044f0:	00000097          	auipc	ra,0x0
    800044f4:	028080e7          	jalr	40(ra) # 80004518 <__printf>
    800044f8:	00002517          	auipc	a0,0x2
    800044fc:	c3850513          	addi	a0,a0,-968 # 80006130 <CONSOLE_STATUS+0x120>
    80004500:	00000097          	auipc	ra,0x0
    80004504:	018080e7          	jalr	24(ra) # 80004518 <__printf>
    80004508:	00100793          	li	a5,1
    8000450c:	00003717          	auipc	a4,0x3
    80004510:	e2f72e23          	sw	a5,-452(a4) # 80007348 <panicked>
    80004514:	0000006f          	j	80004514 <panic+0x58>

0000000080004518 <__printf>:
    80004518:	f3010113          	addi	sp,sp,-208
    8000451c:	08813023          	sd	s0,128(sp)
    80004520:	07313423          	sd	s3,104(sp)
    80004524:	09010413          	addi	s0,sp,144
    80004528:	05813023          	sd	s8,64(sp)
    8000452c:	08113423          	sd	ra,136(sp)
    80004530:	06913c23          	sd	s1,120(sp)
    80004534:	07213823          	sd	s2,112(sp)
    80004538:	07413023          	sd	s4,96(sp)
    8000453c:	05513c23          	sd	s5,88(sp)
    80004540:	05613823          	sd	s6,80(sp)
    80004544:	05713423          	sd	s7,72(sp)
    80004548:	03913c23          	sd	s9,56(sp)
    8000454c:	03a13823          	sd	s10,48(sp)
    80004550:	03b13423          	sd	s11,40(sp)
    80004554:	00004317          	auipc	t1,0x4
    80004558:	2cc30313          	addi	t1,t1,716 # 80008820 <pr>
    8000455c:	01832c03          	lw	s8,24(t1)
    80004560:	00b43423          	sd	a1,8(s0)
    80004564:	00c43823          	sd	a2,16(s0)
    80004568:	00d43c23          	sd	a3,24(s0)
    8000456c:	02e43023          	sd	a4,32(s0)
    80004570:	02f43423          	sd	a5,40(s0)
    80004574:	03043823          	sd	a6,48(s0)
    80004578:	03143c23          	sd	a7,56(s0)
    8000457c:	00050993          	mv	s3,a0
    80004580:	4a0c1663          	bnez	s8,80004a2c <__printf+0x514>
    80004584:	60098c63          	beqz	s3,80004b9c <__printf+0x684>
    80004588:	0009c503          	lbu	a0,0(s3)
    8000458c:	00840793          	addi	a5,s0,8
    80004590:	f6f43c23          	sd	a5,-136(s0)
    80004594:	00000493          	li	s1,0
    80004598:	22050063          	beqz	a0,800047b8 <__printf+0x2a0>
    8000459c:	00002a37          	lui	s4,0x2
    800045a0:	00018ab7          	lui	s5,0x18
    800045a4:	000f4b37          	lui	s6,0xf4
    800045a8:	00989bb7          	lui	s7,0x989
    800045ac:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    800045b0:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    800045b4:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    800045b8:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    800045bc:	00148c9b          	addiw	s9,s1,1
    800045c0:	02500793          	li	a5,37
    800045c4:	01998933          	add	s2,s3,s9
    800045c8:	38f51263          	bne	a0,a5,8000494c <__printf+0x434>
    800045cc:	00094783          	lbu	a5,0(s2)
    800045d0:	00078c9b          	sext.w	s9,a5
    800045d4:	1e078263          	beqz	a5,800047b8 <__printf+0x2a0>
    800045d8:	0024849b          	addiw	s1,s1,2
    800045dc:	07000713          	li	a4,112
    800045e0:	00998933          	add	s2,s3,s1
    800045e4:	38e78a63          	beq	a5,a4,80004978 <__printf+0x460>
    800045e8:	20f76863          	bltu	a4,a5,800047f8 <__printf+0x2e0>
    800045ec:	42a78863          	beq	a5,a0,80004a1c <__printf+0x504>
    800045f0:	06400713          	li	a4,100
    800045f4:	40e79663          	bne	a5,a4,80004a00 <__printf+0x4e8>
    800045f8:	f7843783          	ld	a5,-136(s0)
    800045fc:	0007a603          	lw	a2,0(a5)
    80004600:	00878793          	addi	a5,a5,8
    80004604:	f6f43c23          	sd	a5,-136(s0)
    80004608:	42064a63          	bltz	a2,80004a3c <__printf+0x524>
    8000460c:	00a00713          	li	a4,10
    80004610:	02e677bb          	remuw	a5,a2,a4
    80004614:	00002d97          	auipc	s11,0x2
    80004618:	b64d8d93          	addi	s11,s11,-1180 # 80006178 <digits>
    8000461c:	00900593          	li	a1,9
    80004620:	0006051b          	sext.w	a0,a2
    80004624:	00000c93          	li	s9,0
    80004628:	02079793          	slli	a5,a5,0x20
    8000462c:	0207d793          	srli	a5,a5,0x20
    80004630:	00fd87b3          	add	a5,s11,a5
    80004634:	0007c783          	lbu	a5,0(a5)
    80004638:	02e656bb          	divuw	a3,a2,a4
    8000463c:	f8f40023          	sb	a5,-128(s0)
    80004640:	14c5d863          	bge	a1,a2,80004790 <__printf+0x278>
    80004644:	06300593          	li	a1,99
    80004648:	00100c93          	li	s9,1
    8000464c:	02e6f7bb          	remuw	a5,a3,a4
    80004650:	02079793          	slli	a5,a5,0x20
    80004654:	0207d793          	srli	a5,a5,0x20
    80004658:	00fd87b3          	add	a5,s11,a5
    8000465c:	0007c783          	lbu	a5,0(a5)
    80004660:	02e6d73b          	divuw	a4,a3,a4
    80004664:	f8f400a3          	sb	a5,-127(s0)
    80004668:	12a5f463          	bgeu	a1,a0,80004790 <__printf+0x278>
    8000466c:	00a00693          	li	a3,10
    80004670:	00900593          	li	a1,9
    80004674:	02d777bb          	remuw	a5,a4,a3
    80004678:	02079793          	slli	a5,a5,0x20
    8000467c:	0207d793          	srli	a5,a5,0x20
    80004680:	00fd87b3          	add	a5,s11,a5
    80004684:	0007c503          	lbu	a0,0(a5)
    80004688:	02d757bb          	divuw	a5,a4,a3
    8000468c:	f8a40123          	sb	a0,-126(s0)
    80004690:	48e5f263          	bgeu	a1,a4,80004b14 <__printf+0x5fc>
    80004694:	06300513          	li	a0,99
    80004698:	02d7f5bb          	remuw	a1,a5,a3
    8000469c:	02059593          	slli	a1,a1,0x20
    800046a0:	0205d593          	srli	a1,a1,0x20
    800046a4:	00bd85b3          	add	a1,s11,a1
    800046a8:	0005c583          	lbu	a1,0(a1)
    800046ac:	02d7d7bb          	divuw	a5,a5,a3
    800046b0:	f8b401a3          	sb	a1,-125(s0)
    800046b4:	48e57263          	bgeu	a0,a4,80004b38 <__printf+0x620>
    800046b8:	3e700513          	li	a0,999
    800046bc:	02d7f5bb          	remuw	a1,a5,a3
    800046c0:	02059593          	slli	a1,a1,0x20
    800046c4:	0205d593          	srli	a1,a1,0x20
    800046c8:	00bd85b3          	add	a1,s11,a1
    800046cc:	0005c583          	lbu	a1,0(a1)
    800046d0:	02d7d7bb          	divuw	a5,a5,a3
    800046d4:	f8b40223          	sb	a1,-124(s0)
    800046d8:	46e57663          	bgeu	a0,a4,80004b44 <__printf+0x62c>
    800046dc:	02d7f5bb          	remuw	a1,a5,a3
    800046e0:	02059593          	slli	a1,a1,0x20
    800046e4:	0205d593          	srli	a1,a1,0x20
    800046e8:	00bd85b3          	add	a1,s11,a1
    800046ec:	0005c583          	lbu	a1,0(a1)
    800046f0:	02d7d7bb          	divuw	a5,a5,a3
    800046f4:	f8b402a3          	sb	a1,-123(s0)
    800046f8:	46ea7863          	bgeu	s4,a4,80004b68 <__printf+0x650>
    800046fc:	02d7f5bb          	remuw	a1,a5,a3
    80004700:	02059593          	slli	a1,a1,0x20
    80004704:	0205d593          	srli	a1,a1,0x20
    80004708:	00bd85b3          	add	a1,s11,a1
    8000470c:	0005c583          	lbu	a1,0(a1)
    80004710:	02d7d7bb          	divuw	a5,a5,a3
    80004714:	f8b40323          	sb	a1,-122(s0)
    80004718:	3eeaf863          	bgeu	s5,a4,80004b08 <__printf+0x5f0>
    8000471c:	02d7f5bb          	remuw	a1,a5,a3
    80004720:	02059593          	slli	a1,a1,0x20
    80004724:	0205d593          	srli	a1,a1,0x20
    80004728:	00bd85b3          	add	a1,s11,a1
    8000472c:	0005c583          	lbu	a1,0(a1)
    80004730:	02d7d7bb          	divuw	a5,a5,a3
    80004734:	f8b403a3          	sb	a1,-121(s0)
    80004738:	42eb7e63          	bgeu	s6,a4,80004b74 <__printf+0x65c>
    8000473c:	02d7f5bb          	remuw	a1,a5,a3
    80004740:	02059593          	slli	a1,a1,0x20
    80004744:	0205d593          	srli	a1,a1,0x20
    80004748:	00bd85b3          	add	a1,s11,a1
    8000474c:	0005c583          	lbu	a1,0(a1)
    80004750:	02d7d7bb          	divuw	a5,a5,a3
    80004754:	f8b40423          	sb	a1,-120(s0)
    80004758:	42ebfc63          	bgeu	s7,a4,80004b90 <__printf+0x678>
    8000475c:	02079793          	slli	a5,a5,0x20
    80004760:	0207d793          	srli	a5,a5,0x20
    80004764:	00fd8db3          	add	s11,s11,a5
    80004768:	000dc703          	lbu	a4,0(s11)
    8000476c:	00a00793          	li	a5,10
    80004770:	00900c93          	li	s9,9
    80004774:	f8e404a3          	sb	a4,-119(s0)
    80004778:	00065c63          	bgez	a2,80004790 <__printf+0x278>
    8000477c:	f9040713          	addi	a4,s0,-112
    80004780:	00f70733          	add	a4,a4,a5
    80004784:	02d00693          	li	a3,45
    80004788:	fed70823          	sb	a3,-16(a4)
    8000478c:	00078c93          	mv	s9,a5
    80004790:	f8040793          	addi	a5,s0,-128
    80004794:	01978cb3          	add	s9,a5,s9
    80004798:	f7f40d13          	addi	s10,s0,-129
    8000479c:	000cc503          	lbu	a0,0(s9)
    800047a0:	fffc8c93          	addi	s9,s9,-1
    800047a4:	00000097          	auipc	ra,0x0
    800047a8:	b90080e7          	jalr	-1136(ra) # 80004334 <consputc>
    800047ac:	ffac98e3          	bne	s9,s10,8000479c <__printf+0x284>
    800047b0:	00094503          	lbu	a0,0(s2)
    800047b4:	e00514e3          	bnez	a0,800045bc <__printf+0xa4>
    800047b8:	1a0c1663          	bnez	s8,80004964 <__printf+0x44c>
    800047bc:	08813083          	ld	ra,136(sp)
    800047c0:	08013403          	ld	s0,128(sp)
    800047c4:	07813483          	ld	s1,120(sp)
    800047c8:	07013903          	ld	s2,112(sp)
    800047cc:	06813983          	ld	s3,104(sp)
    800047d0:	06013a03          	ld	s4,96(sp)
    800047d4:	05813a83          	ld	s5,88(sp)
    800047d8:	05013b03          	ld	s6,80(sp)
    800047dc:	04813b83          	ld	s7,72(sp)
    800047e0:	04013c03          	ld	s8,64(sp)
    800047e4:	03813c83          	ld	s9,56(sp)
    800047e8:	03013d03          	ld	s10,48(sp)
    800047ec:	02813d83          	ld	s11,40(sp)
    800047f0:	0d010113          	addi	sp,sp,208
    800047f4:	00008067          	ret
    800047f8:	07300713          	li	a4,115
    800047fc:	1ce78a63          	beq	a5,a4,800049d0 <__printf+0x4b8>
    80004800:	07800713          	li	a4,120
    80004804:	1ee79e63          	bne	a5,a4,80004a00 <__printf+0x4e8>
    80004808:	f7843783          	ld	a5,-136(s0)
    8000480c:	0007a703          	lw	a4,0(a5)
    80004810:	00878793          	addi	a5,a5,8
    80004814:	f6f43c23          	sd	a5,-136(s0)
    80004818:	28074263          	bltz	a4,80004a9c <__printf+0x584>
    8000481c:	00002d97          	auipc	s11,0x2
    80004820:	95cd8d93          	addi	s11,s11,-1700 # 80006178 <digits>
    80004824:	00f77793          	andi	a5,a4,15
    80004828:	00fd87b3          	add	a5,s11,a5
    8000482c:	0007c683          	lbu	a3,0(a5)
    80004830:	00f00613          	li	a2,15
    80004834:	0007079b          	sext.w	a5,a4
    80004838:	f8d40023          	sb	a3,-128(s0)
    8000483c:	0047559b          	srliw	a1,a4,0x4
    80004840:	0047569b          	srliw	a3,a4,0x4
    80004844:	00000c93          	li	s9,0
    80004848:	0ee65063          	bge	a2,a4,80004928 <__printf+0x410>
    8000484c:	00f6f693          	andi	a3,a3,15
    80004850:	00dd86b3          	add	a3,s11,a3
    80004854:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80004858:	0087d79b          	srliw	a5,a5,0x8
    8000485c:	00100c93          	li	s9,1
    80004860:	f8d400a3          	sb	a3,-127(s0)
    80004864:	0cb67263          	bgeu	a2,a1,80004928 <__printf+0x410>
    80004868:	00f7f693          	andi	a3,a5,15
    8000486c:	00dd86b3          	add	a3,s11,a3
    80004870:	0006c583          	lbu	a1,0(a3)
    80004874:	00f00613          	li	a2,15
    80004878:	0047d69b          	srliw	a3,a5,0x4
    8000487c:	f8b40123          	sb	a1,-126(s0)
    80004880:	0047d593          	srli	a1,a5,0x4
    80004884:	28f67e63          	bgeu	a2,a5,80004b20 <__printf+0x608>
    80004888:	00f6f693          	andi	a3,a3,15
    8000488c:	00dd86b3          	add	a3,s11,a3
    80004890:	0006c503          	lbu	a0,0(a3)
    80004894:	0087d813          	srli	a6,a5,0x8
    80004898:	0087d69b          	srliw	a3,a5,0x8
    8000489c:	f8a401a3          	sb	a0,-125(s0)
    800048a0:	28b67663          	bgeu	a2,a1,80004b2c <__printf+0x614>
    800048a4:	00f6f693          	andi	a3,a3,15
    800048a8:	00dd86b3          	add	a3,s11,a3
    800048ac:	0006c583          	lbu	a1,0(a3)
    800048b0:	00c7d513          	srli	a0,a5,0xc
    800048b4:	00c7d69b          	srliw	a3,a5,0xc
    800048b8:	f8b40223          	sb	a1,-124(s0)
    800048bc:	29067a63          	bgeu	a2,a6,80004b50 <__printf+0x638>
    800048c0:	00f6f693          	andi	a3,a3,15
    800048c4:	00dd86b3          	add	a3,s11,a3
    800048c8:	0006c583          	lbu	a1,0(a3)
    800048cc:	0107d813          	srli	a6,a5,0x10
    800048d0:	0107d69b          	srliw	a3,a5,0x10
    800048d4:	f8b402a3          	sb	a1,-123(s0)
    800048d8:	28a67263          	bgeu	a2,a0,80004b5c <__printf+0x644>
    800048dc:	00f6f693          	andi	a3,a3,15
    800048e0:	00dd86b3          	add	a3,s11,a3
    800048e4:	0006c683          	lbu	a3,0(a3)
    800048e8:	0147d79b          	srliw	a5,a5,0x14
    800048ec:	f8d40323          	sb	a3,-122(s0)
    800048f0:	21067663          	bgeu	a2,a6,80004afc <__printf+0x5e4>
    800048f4:	02079793          	slli	a5,a5,0x20
    800048f8:	0207d793          	srli	a5,a5,0x20
    800048fc:	00fd8db3          	add	s11,s11,a5
    80004900:	000dc683          	lbu	a3,0(s11)
    80004904:	00800793          	li	a5,8
    80004908:	00700c93          	li	s9,7
    8000490c:	f8d403a3          	sb	a3,-121(s0)
    80004910:	00075c63          	bgez	a4,80004928 <__printf+0x410>
    80004914:	f9040713          	addi	a4,s0,-112
    80004918:	00f70733          	add	a4,a4,a5
    8000491c:	02d00693          	li	a3,45
    80004920:	fed70823          	sb	a3,-16(a4)
    80004924:	00078c93          	mv	s9,a5
    80004928:	f8040793          	addi	a5,s0,-128
    8000492c:	01978cb3          	add	s9,a5,s9
    80004930:	f7f40d13          	addi	s10,s0,-129
    80004934:	000cc503          	lbu	a0,0(s9)
    80004938:	fffc8c93          	addi	s9,s9,-1
    8000493c:	00000097          	auipc	ra,0x0
    80004940:	9f8080e7          	jalr	-1544(ra) # 80004334 <consputc>
    80004944:	ff9d18e3          	bne	s10,s9,80004934 <__printf+0x41c>
    80004948:	0100006f          	j	80004958 <__printf+0x440>
    8000494c:	00000097          	auipc	ra,0x0
    80004950:	9e8080e7          	jalr	-1560(ra) # 80004334 <consputc>
    80004954:	000c8493          	mv	s1,s9
    80004958:	00094503          	lbu	a0,0(s2)
    8000495c:	c60510e3          	bnez	a0,800045bc <__printf+0xa4>
    80004960:	e40c0ee3          	beqz	s8,800047bc <__printf+0x2a4>
    80004964:	00004517          	auipc	a0,0x4
    80004968:	ebc50513          	addi	a0,a0,-324 # 80008820 <pr>
    8000496c:	00001097          	auipc	ra,0x1
    80004970:	94c080e7          	jalr	-1716(ra) # 800052b8 <release>
    80004974:	e49ff06f          	j	800047bc <__printf+0x2a4>
    80004978:	f7843783          	ld	a5,-136(s0)
    8000497c:	03000513          	li	a0,48
    80004980:	01000d13          	li	s10,16
    80004984:	00878713          	addi	a4,a5,8
    80004988:	0007bc83          	ld	s9,0(a5)
    8000498c:	f6e43c23          	sd	a4,-136(s0)
    80004990:	00000097          	auipc	ra,0x0
    80004994:	9a4080e7          	jalr	-1628(ra) # 80004334 <consputc>
    80004998:	07800513          	li	a0,120
    8000499c:	00000097          	auipc	ra,0x0
    800049a0:	998080e7          	jalr	-1640(ra) # 80004334 <consputc>
    800049a4:	00001d97          	auipc	s11,0x1
    800049a8:	7d4d8d93          	addi	s11,s11,2004 # 80006178 <digits>
    800049ac:	03ccd793          	srli	a5,s9,0x3c
    800049b0:	00fd87b3          	add	a5,s11,a5
    800049b4:	0007c503          	lbu	a0,0(a5)
    800049b8:	fffd0d1b          	addiw	s10,s10,-1
    800049bc:	004c9c93          	slli	s9,s9,0x4
    800049c0:	00000097          	auipc	ra,0x0
    800049c4:	974080e7          	jalr	-1676(ra) # 80004334 <consputc>
    800049c8:	fe0d12e3          	bnez	s10,800049ac <__printf+0x494>
    800049cc:	f8dff06f          	j	80004958 <__printf+0x440>
    800049d0:	f7843783          	ld	a5,-136(s0)
    800049d4:	0007bc83          	ld	s9,0(a5)
    800049d8:	00878793          	addi	a5,a5,8
    800049dc:	f6f43c23          	sd	a5,-136(s0)
    800049e0:	000c9a63          	bnez	s9,800049f4 <__printf+0x4dc>
    800049e4:	1080006f          	j	80004aec <__printf+0x5d4>
    800049e8:	001c8c93          	addi	s9,s9,1
    800049ec:	00000097          	auipc	ra,0x0
    800049f0:	948080e7          	jalr	-1720(ra) # 80004334 <consputc>
    800049f4:	000cc503          	lbu	a0,0(s9)
    800049f8:	fe0518e3          	bnez	a0,800049e8 <__printf+0x4d0>
    800049fc:	f5dff06f          	j	80004958 <__printf+0x440>
    80004a00:	02500513          	li	a0,37
    80004a04:	00000097          	auipc	ra,0x0
    80004a08:	930080e7          	jalr	-1744(ra) # 80004334 <consputc>
    80004a0c:	000c8513          	mv	a0,s9
    80004a10:	00000097          	auipc	ra,0x0
    80004a14:	924080e7          	jalr	-1756(ra) # 80004334 <consputc>
    80004a18:	f41ff06f          	j	80004958 <__printf+0x440>
    80004a1c:	02500513          	li	a0,37
    80004a20:	00000097          	auipc	ra,0x0
    80004a24:	914080e7          	jalr	-1772(ra) # 80004334 <consputc>
    80004a28:	f31ff06f          	j	80004958 <__printf+0x440>
    80004a2c:	00030513          	mv	a0,t1
    80004a30:	00000097          	auipc	ra,0x0
    80004a34:	7bc080e7          	jalr	1980(ra) # 800051ec <acquire>
    80004a38:	b4dff06f          	j	80004584 <__printf+0x6c>
    80004a3c:	40c0053b          	negw	a0,a2
    80004a40:	00a00713          	li	a4,10
    80004a44:	02e576bb          	remuw	a3,a0,a4
    80004a48:	00001d97          	auipc	s11,0x1
    80004a4c:	730d8d93          	addi	s11,s11,1840 # 80006178 <digits>
    80004a50:	ff700593          	li	a1,-9
    80004a54:	02069693          	slli	a3,a3,0x20
    80004a58:	0206d693          	srli	a3,a3,0x20
    80004a5c:	00dd86b3          	add	a3,s11,a3
    80004a60:	0006c683          	lbu	a3,0(a3)
    80004a64:	02e557bb          	divuw	a5,a0,a4
    80004a68:	f8d40023          	sb	a3,-128(s0)
    80004a6c:	10b65e63          	bge	a2,a1,80004b88 <__printf+0x670>
    80004a70:	06300593          	li	a1,99
    80004a74:	02e7f6bb          	remuw	a3,a5,a4
    80004a78:	02069693          	slli	a3,a3,0x20
    80004a7c:	0206d693          	srli	a3,a3,0x20
    80004a80:	00dd86b3          	add	a3,s11,a3
    80004a84:	0006c683          	lbu	a3,0(a3)
    80004a88:	02e7d73b          	divuw	a4,a5,a4
    80004a8c:	00200793          	li	a5,2
    80004a90:	f8d400a3          	sb	a3,-127(s0)
    80004a94:	bca5ece3          	bltu	a1,a0,8000466c <__printf+0x154>
    80004a98:	ce5ff06f          	j	8000477c <__printf+0x264>
    80004a9c:	40e007bb          	negw	a5,a4
    80004aa0:	00001d97          	auipc	s11,0x1
    80004aa4:	6d8d8d93          	addi	s11,s11,1752 # 80006178 <digits>
    80004aa8:	00f7f693          	andi	a3,a5,15
    80004aac:	00dd86b3          	add	a3,s11,a3
    80004ab0:	0006c583          	lbu	a1,0(a3)
    80004ab4:	ff100613          	li	a2,-15
    80004ab8:	0047d69b          	srliw	a3,a5,0x4
    80004abc:	f8b40023          	sb	a1,-128(s0)
    80004ac0:	0047d59b          	srliw	a1,a5,0x4
    80004ac4:	0ac75e63          	bge	a4,a2,80004b80 <__printf+0x668>
    80004ac8:	00f6f693          	andi	a3,a3,15
    80004acc:	00dd86b3          	add	a3,s11,a3
    80004ad0:	0006c603          	lbu	a2,0(a3)
    80004ad4:	00f00693          	li	a3,15
    80004ad8:	0087d79b          	srliw	a5,a5,0x8
    80004adc:	f8c400a3          	sb	a2,-127(s0)
    80004ae0:	d8b6e4e3          	bltu	a3,a1,80004868 <__printf+0x350>
    80004ae4:	00200793          	li	a5,2
    80004ae8:	e2dff06f          	j	80004914 <__printf+0x3fc>
    80004aec:	00001c97          	auipc	s9,0x1
    80004af0:	66cc8c93          	addi	s9,s9,1644 # 80006158 <CONSOLE_STATUS+0x148>
    80004af4:	02800513          	li	a0,40
    80004af8:	ef1ff06f          	j	800049e8 <__printf+0x4d0>
    80004afc:	00700793          	li	a5,7
    80004b00:	00600c93          	li	s9,6
    80004b04:	e0dff06f          	j	80004910 <__printf+0x3f8>
    80004b08:	00700793          	li	a5,7
    80004b0c:	00600c93          	li	s9,6
    80004b10:	c69ff06f          	j	80004778 <__printf+0x260>
    80004b14:	00300793          	li	a5,3
    80004b18:	00200c93          	li	s9,2
    80004b1c:	c5dff06f          	j	80004778 <__printf+0x260>
    80004b20:	00300793          	li	a5,3
    80004b24:	00200c93          	li	s9,2
    80004b28:	de9ff06f          	j	80004910 <__printf+0x3f8>
    80004b2c:	00400793          	li	a5,4
    80004b30:	00300c93          	li	s9,3
    80004b34:	dddff06f          	j	80004910 <__printf+0x3f8>
    80004b38:	00400793          	li	a5,4
    80004b3c:	00300c93          	li	s9,3
    80004b40:	c39ff06f          	j	80004778 <__printf+0x260>
    80004b44:	00500793          	li	a5,5
    80004b48:	00400c93          	li	s9,4
    80004b4c:	c2dff06f          	j	80004778 <__printf+0x260>
    80004b50:	00500793          	li	a5,5
    80004b54:	00400c93          	li	s9,4
    80004b58:	db9ff06f          	j	80004910 <__printf+0x3f8>
    80004b5c:	00600793          	li	a5,6
    80004b60:	00500c93          	li	s9,5
    80004b64:	dadff06f          	j	80004910 <__printf+0x3f8>
    80004b68:	00600793          	li	a5,6
    80004b6c:	00500c93          	li	s9,5
    80004b70:	c09ff06f          	j	80004778 <__printf+0x260>
    80004b74:	00800793          	li	a5,8
    80004b78:	00700c93          	li	s9,7
    80004b7c:	bfdff06f          	j	80004778 <__printf+0x260>
    80004b80:	00100793          	li	a5,1
    80004b84:	d91ff06f          	j	80004914 <__printf+0x3fc>
    80004b88:	00100793          	li	a5,1
    80004b8c:	bf1ff06f          	j	8000477c <__printf+0x264>
    80004b90:	00900793          	li	a5,9
    80004b94:	00800c93          	li	s9,8
    80004b98:	be1ff06f          	j	80004778 <__printf+0x260>
    80004b9c:	00001517          	auipc	a0,0x1
    80004ba0:	5c450513          	addi	a0,a0,1476 # 80006160 <CONSOLE_STATUS+0x150>
    80004ba4:	00000097          	auipc	ra,0x0
    80004ba8:	918080e7          	jalr	-1768(ra) # 800044bc <panic>

0000000080004bac <printfinit>:
    80004bac:	fe010113          	addi	sp,sp,-32
    80004bb0:	00813823          	sd	s0,16(sp)
    80004bb4:	00913423          	sd	s1,8(sp)
    80004bb8:	00113c23          	sd	ra,24(sp)
    80004bbc:	02010413          	addi	s0,sp,32
    80004bc0:	00004497          	auipc	s1,0x4
    80004bc4:	c6048493          	addi	s1,s1,-928 # 80008820 <pr>
    80004bc8:	00048513          	mv	a0,s1
    80004bcc:	00001597          	auipc	a1,0x1
    80004bd0:	5a458593          	addi	a1,a1,1444 # 80006170 <CONSOLE_STATUS+0x160>
    80004bd4:	00000097          	auipc	ra,0x0
    80004bd8:	5f4080e7          	jalr	1524(ra) # 800051c8 <initlock>
    80004bdc:	01813083          	ld	ra,24(sp)
    80004be0:	01013403          	ld	s0,16(sp)
    80004be4:	0004ac23          	sw	zero,24(s1)
    80004be8:	00813483          	ld	s1,8(sp)
    80004bec:	02010113          	addi	sp,sp,32
    80004bf0:	00008067          	ret

0000000080004bf4 <uartinit>:
    80004bf4:	ff010113          	addi	sp,sp,-16
    80004bf8:	00813423          	sd	s0,8(sp)
    80004bfc:	01010413          	addi	s0,sp,16
    80004c00:	100007b7          	lui	a5,0x10000
    80004c04:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80004c08:	f8000713          	li	a4,-128
    80004c0c:	00e781a3          	sb	a4,3(a5)
    80004c10:	00300713          	li	a4,3
    80004c14:	00e78023          	sb	a4,0(a5)
    80004c18:	000780a3          	sb	zero,1(a5)
    80004c1c:	00e781a3          	sb	a4,3(a5)
    80004c20:	00700693          	li	a3,7
    80004c24:	00d78123          	sb	a3,2(a5)
    80004c28:	00e780a3          	sb	a4,1(a5)
    80004c2c:	00813403          	ld	s0,8(sp)
    80004c30:	01010113          	addi	sp,sp,16
    80004c34:	00008067          	ret

0000000080004c38 <uartputc>:
    80004c38:	00002797          	auipc	a5,0x2
    80004c3c:	7107a783          	lw	a5,1808(a5) # 80007348 <panicked>
    80004c40:	00078463          	beqz	a5,80004c48 <uartputc+0x10>
    80004c44:	0000006f          	j	80004c44 <uartputc+0xc>
    80004c48:	fd010113          	addi	sp,sp,-48
    80004c4c:	02813023          	sd	s0,32(sp)
    80004c50:	00913c23          	sd	s1,24(sp)
    80004c54:	01213823          	sd	s2,16(sp)
    80004c58:	01313423          	sd	s3,8(sp)
    80004c5c:	02113423          	sd	ra,40(sp)
    80004c60:	03010413          	addi	s0,sp,48
    80004c64:	00002917          	auipc	s2,0x2
    80004c68:	6ec90913          	addi	s2,s2,1772 # 80007350 <uart_tx_r>
    80004c6c:	00093783          	ld	a5,0(s2)
    80004c70:	00002497          	auipc	s1,0x2
    80004c74:	6e848493          	addi	s1,s1,1768 # 80007358 <uart_tx_w>
    80004c78:	0004b703          	ld	a4,0(s1)
    80004c7c:	02078693          	addi	a3,a5,32
    80004c80:	00050993          	mv	s3,a0
    80004c84:	02e69c63          	bne	a3,a4,80004cbc <uartputc+0x84>
    80004c88:	00001097          	auipc	ra,0x1
    80004c8c:	834080e7          	jalr	-1996(ra) # 800054bc <push_on>
    80004c90:	00093783          	ld	a5,0(s2)
    80004c94:	0004b703          	ld	a4,0(s1)
    80004c98:	02078793          	addi	a5,a5,32
    80004c9c:	00e79463          	bne	a5,a4,80004ca4 <uartputc+0x6c>
    80004ca0:	0000006f          	j	80004ca0 <uartputc+0x68>
    80004ca4:	00001097          	auipc	ra,0x1
    80004ca8:	88c080e7          	jalr	-1908(ra) # 80005530 <pop_on>
    80004cac:	00093783          	ld	a5,0(s2)
    80004cb0:	0004b703          	ld	a4,0(s1)
    80004cb4:	02078693          	addi	a3,a5,32
    80004cb8:	fce688e3          	beq	a3,a4,80004c88 <uartputc+0x50>
    80004cbc:	01f77693          	andi	a3,a4,31
    80004cc0:	00004597          	auipc	a1,0x4
    80004cc4:	b8058593          	addi	a1,a1,-1152 # 80008840 <uart_tx_buf>
    80004cc8:	00d586b3          	add	a3,a1,a3
    80004ccc:	00170713          	addi	a4,a4,1
    80004cd0:	01368023          	sb	s3,0(a3)
    80004cd4:	00e4b023          	sd	a4,0(s1)
    80004cd8:	10000637          	lui	a2,0x10000
    80004cdc:	02f71063          	bne	a4,a5,80004cfc <uartputc+0xc4>
    80004ce0:	0340006f          	j	80004d14 <uartputc+0xdc>
    80004ce4:	00074703          	lbu	a4,0(a4)
    80004ce8:	00f93023          	sd	a5,0(s2)
    80004cec:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80004cf0:	00093783          	ld	a5,0(s2)
    80004cf4:	0004b703          	ld	a4,0(s1)
    80004cf8:	00f70e63          	beq	a4,a5,80004d14 <uartputc+0xdc>
    80004cfc:	00564683          	lbu	a3,5(a2)
    80004d00:	01f7f713          	andi	a4,a5,31
    80004d04:	00e58733          	add	a4,a1,a4
    80004d08:	0206f693          	andi	a3,a3,32
    80004d0c:	00178793          	addi	a5,a5,1
    80004d10:	fc069ae3          	bnez	a3,80004ce4 <uartputc+0xac>
    80004d14:	02813083          	ld	ra,40(sp)
    80004d18:	02013403          	ld	s0,32(sp)
    80004d1c:	01813483          	ld	s1,24(sp)
    80004d20:	01013903          	ld	s2,16(sp)
    80004d24:	00813983          	ld	s3,8(sp)
    80004d28:	03010113          	addi	sp,sp,48
    80004d2c:	00008067          	ret

0000000080004d30 <uartputc_sync>:
    80004d30:	ff010113          	addi	sp,sp,-16
    80004d34:	00813423          	sd	s0,8(sp)
    80004d38:	01010413          	addi	s0,sp,16
    80004d3c:	00002717          	auipc	a4,0x2
    80004d40:	60c72703          	lw	a4,1548(a4) # 80007348 <panicked>
    80004d44:	02071663          	bnez	a4,80004d70 <uartputc_sync+0x40>
    80004d48:	00050793          	mv	a5,a0
    80004d4c:	100006b7          	lui	a3,0x10000
    80004d50:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80004d54:	02077713          	andi	a4,a4,32
    80004d58:	fe070ce3          	beqz	a4,80004d50 <uartputc_sync+0x20>
    80004d5c:	0ff7f793          	andi	a5,a5,255
    80004d60:	00f68023          	sb	a5,0(a3)
    80004d64:	00813403          	ld	s0,8(sp)
    80004d68:	01010113          	addi	sp,sp,16
    80004d6c:	00008067          	ret
    80004d70:	0000006f          	j	80004d70 <uartputc_sync+0x40>

0000000080004d74 <uartstart>:
    80004d74:	ff010113          	addi	sp,sp,-16
    80004d78:	00813423          	sd	s0,8(sp)
    80004d7c:	01010413          	addi	s0,sp,16
    80004d80:	00002617          	auipc	a2,0x2
    80004d84:	5d060613          	addi	a2,a2,1488 # 80007350 <uart_tx_r>
    80004d88:	00002517          	auipc	a0,0x2
    80004d8c:	5d050513          	addi	a0,a0,1488 # 80007358 <uart_tx_w>
    80004d90:	00063783          	ld	a5,0(a2)
    80004d94:	00053703          	ld	a4,0(a0)
    80004d98:	04f70263          	beq	a4,a5,80004ddc <uartstart+0x68>
    80004d9c:	100005b7          	lui	a1,0x10000
    80004da0:	00004817          	auipc	a6,0x4
    80004da4:	aa080813          	addi	a6,a6,-1376 # 80008840 <uart_tx_buf>
    80004da8:	01c0006f          	j	80004dc4 <uartstart+0x50>
    80004dac:	0006c703          	lbu	a4,0(a3)
    80004db0:	00f63023          	sd	a5,0(a2)
    80004db4:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80004db8:	00063783          	ld	a5,0(a2)
    80004dbc:	00053703          	ld	a4,0(a0)
    80004dc0:	00f70e63          	beq	a4,a5,80004ddc <uartstart+0x68>
    80004dc4:	01f7f713          	andi	a4,a5,31
    80004dc8:	00e806b3          	add	a3,a6,a4
    80004dcc:	0055c703          	lbu	a4,5(a1)
    80004dd0:	00178793          	addi	a5,a5,1
    80004dd4:	02077713          	andi	a4,a4,32
    80004dd8:	fc071ae3          	bnez	a4,80004dac <uartstart+0x38>
    80004ddc:	00813403          	ld	s0,8(sp)
    80004de0:	01010113          	addi	sp,sp,16
    80004de4:	00008067          	ret

0000000080004de8 <uartgetc>:
    80004de8:	ff010113          	addi	sp,sp,-16
    80004dec:	00813423          	sd	s0,8(sp)
    80004df0:	01010413          	addi	s0,sp,16
    80004df4:	10000737          	lui	a4,0x10000
    80004df8:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80004dfc:	0017f793          	andi	a5,a5,1
    80004e00:	00078c63          	beqz	a5,80004e18 <uartgetc+0x30>
    80004e04:	00074503          	lbu	a0,0(a4)
    80004e08:	0ff57513          	andi	a0,a0,255
    80004e0c:	00813403          	ld	s0,8(sp)
    80004e10:	01010113          	addi	sp,sp,16
    80004e14:	00008067          	ret
    80004e18:	fff00513          	li	a0,-1
    80004e1c:	ff1ff06f          	j	80004e0c <uartgetc+0x24>

0000000080004e20 <uartintr>:
    80004e20:	100007b7          	lui	a5,0x10000
    80004e24:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80004e28:	0017f793          	andi	a5,a5,1
    80004e2c:	0a078463          	beqz	a5,80004ed4 <uartintr+0xb4>
    80004e30:	fe010113          	addi	sp,sp,-32
    80004e34:	00813823          	sd	s0,16(sp)
    80004e38:	00913423          	sd	s1,8(sp)
    80004e3c:	00113c23          	sd	ra,24(sp)
    80004e40:	02010413          	addi	s0,sp,32
    80004e44:	100004b7          	lui	s1,0x10000
    80004e48:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    80004e4c:	0ff57513          	andi	a0,a0,255
    80004e50:	fffff097          	auipc	ra,0xfffff
    80004e54:	534080e7          	jalr	1332(ra) # 80004384 <consoleintr>
    80004e58:	0054c783          	lbu	a5,5(s1)
    80004e5c:	0017f793          	andi	a5,a5,1
    80004e60:	fe0794e3          	bnez	a5,80004e48 <uartintr+0x28>
    80004e64:	00002617          	auipc	a2,0x2
    80004e68:	4ec60613          	addi	a2,a2,1260 # 80007350 <uart_tx_r>
    80004e6c:	00002517          	auipc	a0,0x2
    80004e70:	4ec50513          	addi	a0,a0,1260 # 80007358 <uart_tx_w>
    80004e74:	00063783          	ld	a5,0(a2)
    80004e78:	00053703          	ld	a4,0(a0)
    80004e7c:	04f70263          	beq	a4,a5,80004ec0 <uartintr+0xa0>
    80004e80:	100005b7          	lui	a1,0x10000
    80004e84:	00004817          	auipc	a6,0x4
    80004e88:	9bc80813          	addi	a6,a6,-1604 # 80008840 <uart_tx_buf>
    80004e8c:	01c0006f          	j	80004ea8 <uartintr+0x88>
    80004e90:	0006c703          	lbu	a4,0(a3)
    80004e94:	00f63023          	sd	a5,0(a2)
    80004e98:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80004e9c:	00063783          	ld	a5,0(a2)
    80004ea0:	00053703          	ld	a4,0(a0)
    80004ea4:	00f70e63          	beq	a4,a5,80004ec0 <uartintr+0xa0>
    80004ea8:	01f7f713          	andi	a4,a5,31
    80004eac:	00e806b3          	add	a3,a6,a4
    80004eb0:	0055c703          	lbu	a4,5(a1)
    80004eb4:	00178793          	addi	a5,a5,1
    80004eb8:	02077713          	andi	a4,a4,32
    80004ebc:	fc071ae3          	bnez	a4,80004e90 <uartintr+0x70>
    80004ec0:	01813083          	ld	ra,24(sp)
    80004ec4:	01013403          	ld	s0,16(sp)
    80004ec8:	00813483          	ld	s1,8(sp)
    80004ecc:	02010113          	addi	sp,sp,32
    80004ed0:	00008067          	ret
    80004ed4:	00002617          	auipc	a2,0x2
    80004ed8:	47c60613          	addi	a2,a2,1148 # 80007350 <uart_tx_r>
    80004edc:	00002517          	auipc	a0,0x2
    80004ee0:	47c50513          	addi	a0,a0,1148 # 80007358 <uart_tx_w>
    80004ee4:	00063783          	ld	a5,0(a2)
    80004ee8:	00053703          	ld	a4,0(a0)
    80004eec:	04f70263          	beq	a4,a5,80004f30 <uartintr+0x110>
    80004ef0:	100005b7          	lui	a1,0x10000
    80004ef4:	00004817          	auipc	a6,0x4
    80004ef8:	94c80813          	addi	a6,a6,-1716 # 80008840 <uart_tx_buf>
    80004efc:	01c0006f          	j	80004f18 <uartintr+0xf8>
    80004f00:	0006c703          	lbu	a4,0(a3)
    80004f04:	00f63023          	sd	a5,0(a2)
    80004f08:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80004f0c:	00063783          	ld	a5,0(a2)
    80004f10:	00053703          	ld	a4,0(a0)
    80004f14:	02f70063          	beq	a4,a5,80004f34 <uartintr+0x114>
    80004f18:	01f7f713          	andi	a4,a5,31
    80004f1c:	00e806b3          	add	a3,a6,a4
    80004f20:	0055c703          	lbu	a4,5(a1)
    80004f24:	00178793          	addi	a5,a5,1
    80004f28:	02077713          	andi	a4,a4,32
    80004f2c:	fc071ae3          	bnez	a4,80004f00 <uartintr+0xe0>
    80004f30:	00008067          	ret
    80004f34:	00008067          	ret

0000000080004f38 <kinit>:
    80004f38:	fc010113          	addi	sp,sp,-64
    80004f3c:	02913423          	sd	s1,40(sp)
    80004f40:	fffff7b7          	lui	a5,0xfffff
    80004f44:	00005497          	auipc	s1,0x5
    80004f48:	91b48493          	addi	s1,s1,-1765 # 8000985f <end+0xfff>
    80004f4c:	02813823          	sd	s0,48(sp)
    80004f50:	01313c23          	sd	s3,24(sp)
    80004f54:	00f4f4b3          	and	s1,s1,a5
    80004f58:	02113c23          	sd	ra,56(sp)
    80004f5c:	03213023          	sd	s2,32(sp)
    80004f60:	01413823          	sd	s4,16(sp)
    80004f64:	01513423          	sd	s5,8(sp)
    80004f68:	04010413          	addi	s0,sp,64
    80004f6c:	000017b7          	lui	a5,0x1
    80004f70:	01100993          	li	s3,17
    80004f74:	00f487b3          	add	a5,s1,a5
    80004f78:	01b99993          	slli	s3,s3,0x1b
    80004f7c:	06f9e063          	bltu	s3,a5,80004fdc <kinit+0xa4>
    80004f80:	00004a97          	auipc	s5,0x4
    80004f84:	8e0a8a93          	addi	s5,s5,-1824 # 80008860 <end>
    80004f88:	0754ec63          	bltu	s1,s5,80005000 <kinit+0xc8>
    80004f8c:	0734fa63          	bgeu	s1,s3,80005000 <kinit+0xc8>
    80004f90:	00088a37          	lui	s4,0x88
    80004f94:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80004f98:	00002917          	auipc	s2,0x2
    80004f9c:	3c890913          	addi	s2,s2,968 # 80007360 <kmem>
    80004fa0:	00ca1a13          	slli	s4,s4,0xc
    80004fa4:	0140006f          	j	80004fb8 <kinit+0x80>
    80004fa8:	000017b7          	lui	a5,0x1
    80004fac:	00f484b3          	add	s1,s1,a5
    80004fb0:	0554e863          	bltu	s1,s5,80005000 <kinit+0xc8>
    80004fb4:	0534f663          	bgeu	s1,s3,80005000 <kinit+0xc8>
    80004fb8:	00001637          	lui	a2,0x1
    80004fbc:	00100593          	li	a1,1
    80004fc0:	00048513          	mv	a0,s1
    80004fc4:	00000097          	auipc	ra,0x0
    80004fc8:	5e4080e7          	jalr	1508(ra) # 800055a8 <__memset>
    80004fcc:	00093783          	ld	a5,0(s2)
    80004fd0:	00f4b023          	sd	a5,0(s1)
    80004fd4:	00993023          	sd	s1,0(s2)
    80004fd8:	fd4498e3          	bne	s1,s4,80004fa8 <kinit+0x70>
    80004fdc:	03813083          	ld	ra,56(sp)
    80004fe0:	03013403          	ld	s0,48(sp)
    80004fe4:	02813483          	ld	s1,40(sp)
    80004fe8:	02013903          	ld	s2,32(sp)
    80004fec:	01813983          	ld	s3,24(sp)
    80004ff0:	01013a03          	ld	s4,16(sp)
    80004ff4:	00813a83          	ld	s5,8(sp)
    80004ff8:	04010113          	addi	sp,sp,64
    80004ffc:	00008067          	ret
    80005000:	00001517          	auipc	a0,0x1
    80005004:	19050513          	addi	a0,a0,400 # 80006190 <digits+0x18>
    80005008:	fffff097          	auipc	ra,0xfffff
    8000500c:	4b4080e7          	jalr	1204(ra) # 800044bc <panic>

0000000080005010 <freerange>:
    80005010:	fc010113          	addi	sp,sp,-64
    80005014:	000017b7          	lui	a5,0x1
    80005018:	02913423          	sd	s1,40(sp)
    8000501c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80005020:	009504b3          	add	s1,a0,s1
    80005024:	fffff537          	lui	a0,0xfffff
    80005028:	02813823          	sd	s0,48(sp)
    8000502c:	02113c23          	sd	ra,56(sp)
    80005030:	03213023          	sd	s2,32(sp)
    80005034:	01313c23          	sd	s3,24(sp)
    80005038:	01413823          	sd	s4,16(sp)
    8000503c:	01513423          	sd	s5,8(sp)
    80005040:	01613023          	sd	s6,0(sp)
    80005044:	04010413          	addi	s0,sp,64
    80005048:	00a4f4b3          	and	s1,s1,a0
    8000504c:	00f487b3          	add	a5,s1,a5
    80005050:	06f5e463          	bltu	a1,a5,800050b8 <freerange+0xa8>
    80005054:	00004a97          	auipc	s5,0x4
    80005058:	80ca8a93          	addi	s5,s5,-2036 # 80008860 <end>
    8000505c:	0954e263          	bltu	s1,s5,800050e0 <freerange+0xd0>
    80005060:	01100993          	li	s3,17
    80005064:	01b99993          	slli	s3,s3,0x1b
    80005068:	0734fc63          	bgeu	s1,s3,800050e0 <freerange+0xd0>
    8000506c:	00058a13          	mv	s4,a1
    80005070:	00002917          	auipc	s2,0x2
    80005074:	2f090913          	addi	s2,s2,752 # 80007360 <kmem>
    80005078:	00002b37          	lui	s6,0x2
    8000507c:	0140006f          	j	80005090 <freerange+0x80>
    80005080:	000017b7          	lui	a5,0x1
    80005084:	00f484b3          	add	s1,s1,a5
    80005088:	0554ec63          	bltu	s1,s5,800050e0 <freerange+0xd0>
    8000508c:	0534fa63          	bgeu	s1,s3,800050e0 <freerange+0xd0>
    80005090:	00001637          	lui	a2,0x1
    80005094:	00100593          	li	a1,1
    80005098:	00048513          	mv	a0,s1
    8000509c:	00000097          	auipc	ra,0x0
    800050a0:	50c080e7          	jalr	1292(ra) # 800055a8 <__memset>
    800050a4:	00093703          	ld	a4,0(s2)
    800050a8:	016487b3          	add	a5,s1,s6
    800050ac:	00e4b023          	sd	a4,0(s1)
    800050b0:	00993023          	sd	s1,0(s2)
    800050b4:	fcfa76e3          	bgeu	s4,a5,80005080 <freerange+0x70>
    800050b8:	03813083          	ld	ra,56(sp)
    800050bc:	03013403          	ld	s0,48(sp)
    800050c0:	02813483          	ld	s1,40(sp)
    800050c4:	02013903          	ld	s2,32(sp)
    800050c8:	01813983          	ld	s3,24(sp)
    800050cc:	01013a03          	ld	s4,16(sp)
    800050d0:	00813a83          	ld	s5,8(sp)
    800050d4:	00013b03          	ld	s6,0(sp)
    800050d8:	04010113          	addi	sp,sp,64
    800050dc:	00008067          	ret
    800050e0:	00001517          	auipc	a0,0x1
    800050e4:	0b050513          	addi	a0,a0,176 # 80006190 <digits+0x18>
    800050e8:	fffff097          	auipc	ra,0xfffff
    800050ec:	3d4080e7          	jalr	980(ra) # 800044bc <panic>

00000000800050f0 <kfree>:
    800050f0:	fe010113          	addi	sp,sp,-32
    800050f4:	00813823          	sd	s0,16(sp)
    800050f8:	00113c23          	sd	ra,24(sp)
    800050fc:	00913423          	sd	s1,8(sp)
    80005100:	02010413          	addi	s0,sp,32
    80005104:	03451793          	slli	a5,a0,0x34
    80005108:	04079c63          	bnez	a5,80005160 <kfree+0x70>
    8000510c:	00003797          	auipc	a5,0x3
    80005110:	75478793          	addi	a5,a5,1876 # 80008860 <end>
    80005114:	00050493          	mv	s1,a0
    80005118:	04f56463          	bltu	a0,a5,80005160 <kfree+0x70>
    8000511c:	01100793          	li	a5,17
    80005120:	01b79793          	slli	a5,a5,0x1b
    80005124:	02f57e63          	bgeu	a0,a5,80005160 <kfree+0x70>
    80005128:	00001637          	lui	a2,0x1
    8000512c:	00100593          	li	a1,1
    80005130:	00000097          	auipc	ra,0x0
    80005134:	478080e7          	jalr	1144(ra) # 800055a8 <__memset>
    80005138:	00002797          	auipc	a5,0x2
    8000513c:	22878793          	addi	a5,a5,552 # 80007360 <kmem>
    80005140:	0007b703          	ld	a4,0(a5)
    80005144:	01813083          	ld	ra,24(sp)
    80005148:	01013403          	ld	s0,16(sp)
    8000514c:	00e4b023          	sd	a4,0(s1)
    80005150:	0097b023          	sd	s1,0(a5)
    80005154:	00813483          	ld	s1,8(sp)
    80005158:	02010113          	addi	sp,sp,32
    8000515c:	00008067          	ret
    80005160:	00001517          	auipc	a0,0x1
    80005164:	03050513          	addi	a0,a0,48 # 80006190 <digits+0x18>
    80005168:	fffff097          	auipc	ra,0xfffff
    8000516c:	354080e7          	jalr	852(ra) # 800044bc <panic>

0000000080005170 <kalloc>:
    80005170:	fe010113          	addi	sp,sp,-32
    80005174:	00813823          	sd	s0,16(sp)
    80005178:	00913423          	sd	s1,8(sp)
    8000517c:	00113c23          	sd	ra,24(sp)
    80005180:	02010413          	addi	s0,sp,32
    80005184:	00002797          	auipc	a5,0x2
    80005188:	1dc78793          	addi	a5,a5,476 # 80007360 <kmem>
    8000518c:	0007b483          	ld	s1,0(a5)
    80005190:	02048063          	beqz	s1,800051b0 <kalloc+0x40>
    80005194:	0004b703          	ld	a4,0(s1)
    80005198:	00001637          	lui	a2,0x1
    8000519c:	00500593          	li	a1,5
    800051a0:	00048513          	mv	a0,s1
    800051a4:	00e7b023          	sd	a4,0(a5)
    800051a8:	00000097          	auipc	ra,0x0
    800051ac:	400080e7          	jalr	1024(ra) # 800055a8 <__memset>
    800051b0:	01813083          	ld	ra,24(sp)
    800051b4:	01013403          	ld	s0,16(sp)
    800051b8:	00048513          	mv	a0,s1
    800051bc:	00813483          	ld	s1,8(sp)
    800051c0:	02010113          	addi	sp,sp,32
    800051c4:	00008067          	ret

00000000800051c8 <initlock>:
    800051c8:	ff010113          	addi	sp,sp,-16
    800051cc:	00813423          	sd	s0,8(sp)
    800051d0:	01010413          	addi	s0,sp,16
    800051d4:	00813403          	ld	s0,8(sp)
    800051d8:	00b53423          	sd	a1,8(a0)
    800051dc:	00052023          	sw	zero,0(a0)
    800051e0:	00053823          	sd	zero,16(a0)
    800051e4:	01010113          	addi	sp,sp,16
    800051e8:	00008067          	ret

00000000800051ec <acquire>:
    800051ec:	fe010113          	addi	sp,sp,-32
    800051f0:	00813823          	sd	s0,16(sp)
    800051f4:	00913423          	sd	s1,8(sp)
    800051f8:	00113c23          	sd	ra,24(sp)
    800051fc:	01213023          	sd	s2,0(sp)
    80005200:	02010413          	addi	s0,sp,32
    80005204:	00050493          	mv	s1,a0
    80005208:	10002973          	csrr	s2,sstatus
    8000520c:	100027f3          	csrr	a5,sstatus
    80005210:	ffd7f793          	andi	a5,a5,-3
    80005214:	10079073          	csrw	sstatus,a5
    80005218:	fffff097          	auipc	ra,0xfffff
    8000521c:	8ec080e7          	jalr	-1812(ra) # 80003b04 <mycpu>
    80005220:	07852783          	lw	a5,120(a0)
    80005224:	06078e63          	beqz	a5,800052a0 <acquire+0xb4>
    80005228:	fffff097          	auipc	ra,0xfffff
    8000522c:	8dc080e7          	jalr	-1828(ra) # 80003b04 <mycpu>
    80005230:	07852783          	lw	a5,120(a0)
    80005234:	0004a703          	lw	a4,0(s1)
    80005238:	0017879b          	addiw	a5,a5,1
    8000523c:	06f52c23          	sw	a5,120(a0)
    80005240:	04071063          	bnez	a4,80005280 <acquire+0x94>
    80005244:	00100713          	li	a4,1
    80005248:	00070793          	mv	a5,a4
    8000524c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80005250:	0007879b          	sext.w	a5,a5
    80005254:	fe079ae3          	bnez	a5,80005248 <acquire+0x5c>
    80005258:	0ff0000f          	fence
    8000525c:	fffff097          	auipc	ra,0xfffff
    80005260:	8a8080e7          	jalr	-1880(ra) # 80003b04 <mycpu>
    80005264:	01813083          	ld	ra,24(sp)
    80005268:	01013403          	ld	s0,16(sp)
    8000526c:	00a4b823          	sd	a0,16(s1)
    80005270:	00013903          	ld	s2,0(sp)
    80005274:	00813483          	ld	s1,8(sp)
    80005278:	02010113          	addi	sp,sp,32
    8000527c:	00008067          	ret
    80005280:	0104b903          	ld	s2,16(s1)
    80005284:	fffff097          	auipc	ra,0xfffff
    80005288:	880080e7          	jalr	-1920(ra) # 80003b04 <mycpu>
    8000528c:	faa91ce3          	bne	s2,a0,80005244 <acquire+0x58>
    80005290:	00001517          	auipc	a0,0x1
    80005294:	f0850513          	addi	a0,a0,-248 # 80006198 <digits+0x20>
    80005298:	fffff097          	auipc	ra,0xfffff
    8000529c:	224080e7          	jalr	548(ra) # 800044bc <panic>
    800052a0:	00195913          	srli	s2,s2,0x1
    800052a4:	fffff097          	auipc	ra,0xfffff
    800052a8:	860080e7          	jalr	-1952(ra) # 80003b04 <mycpu>
    800052ac:	00197913          	andi	s2,s2,1
    800052b0:	07252e23          	sw	s2,124(a0)
    800052b4:	f75ff06f          	j	80005228 <acquire+0x3c>

00000000800052b8 <release>:
    800052b8:	fe010113          	addi	sp,sp,-32
    800052bc:	00813823          	sd	s0,16(sp)
    800052c0:	00113c23          	sd	ra,24(sp)
    800052c4:	00913423          	sd	s1,8(sp)
    800052c8:	01213023          	sd	s2,0(sp)
    800052cc:	02010413          	addi	s0,sp,32
    800052d0:	00052783          	lw	a5,0(a0)
    800052d4:	00079a63          	bnez	a5,800052e8 <release+0x30>
    800052d8:	00001517          	auipc	a0,0x1
    800052dc:	ec850513          	addi	a0,a0,-312 # 800061a0 <digits+0x28>
    800052e0:	fffff097          	auipc	ra,0xfffff
    800052e4:	1dc080e7          	jalr	476(ra) # 800044bc <panic>
    800052e8:	01053903          	ld	s2,16(a0)
    800052ec:	00050493          	mv	s1,a0
    800052f0:	fffff097          	auipc	ra,0xfffff
    800052f4:	814080e7          	jalr	-2028(ra) # 80003b04 <mycpu>
    800052f8:	fea910e3          	bne	s2,a0,800052d8 <release+0x20>
    800052fc:	0004b823          	sd	zero,16(s1)
    80005300:	0ff0000f          	fence
    80005304:	0f50000f          	fence	iorw,ow
    80005308:	0804a02f          	amoswap.w	zero,zero,(s1)
    8000530c:	ffffe097          	auipc	ra,0xffffe
    80005310:	7f8080e7          	jalr	2040(ra) # 80003b04 <mycpu>
    80005314:	100027f3          	csrr	a5,sstatus
    80005318:	0027f793          	andi	a5,a5,2
    8000531c:	04079a63          	bnez	a5,80005370 <release+0xb8>
    80005320:	07852783          	lw	a5,120(a0)
    80005324:	02f05e63          	blez	a5,80005360 <release+0xa8>
    80005328:	fff7871b          	addiw	a4,a5,-1
    8000532c:	06e52c23          	sw	a4,120(a0)
    80005330:	00071c63          	bnez	a4,80005348 <release+0x90>
    80005334:	07c52783          	lw	a5,124(a0)
    80005338:	00078863          	beqz	a5,80005348 <release+0x90>
    8000533c:	100027f3          	csrr	a5,sstatus
    80005340:	0027e793          	ori	a5,a5,2
    80005344:	10079073          	csrw	sstatus,a5
    80005348:	01813083          	ld	ra,24(sp)
    8000534c:	01013403          	ld	s0,16(sp)
    80005350:	00813483          	ld	s1,8(sp)
    80005354:	00013903          	ld	s2,0(sp)
    80005358:	02010113          	addi	sp,sp,32
    8000535c:	00008067          	ret
    80005360:	00001517          	auipc	a0,0x1
    80005364:	e6050513          	addi	a0,a0,-416 # 800061c0 <digits+0x48>
    80005368:	fffff097          	auipc	ra,0xfffff
    8000536c:	154080e7          	jalr	340(ra) # 800044bc <panic>
    80005370:	00001517          	auipc	a0,0x1
    80005374:	e3850513          	addi	a0,a0,-456 # 800061a8 <digits+0x30>
    80005378:	fffff097          	auipc	ra,0xfffff
    8000537c:	144080e7          	jalr	324(ra) # 800044bc <panic>

0000000080005380 <holding>:
    80005380:	00052783          	lw	a5,0(a0)
    80005384:	00079663          	bnez	a5,80005390 <holding+0x10>
    80005388:	00000513          	li	a0,0
    8000538c:	00008067          	ret
    80005390:	fe010113          	addi	sp,sp,-32
    80005394:	00813823          	sd	s0,16(sp)
    80005398:	00913423          	sd	s1,8(sp)
    8000539c:	00113c23          	sd	ra,24(sp)
    800053a0:	02010413          	addi	s0,sp,32
    800053a4:	01053483          	ld	s1,16(a0)
    800053a8:	ffffe097          	auipc	ra,0xffffe
    800053ac:	75c080e7          	jalr	1884(ra) # 80003b04 <mycpu>
    800053b0:	01813083          	ld	ra,24(sp)
    800053b4:	01013403          	ld	s0,16(sp)
    800053b8:	40a48533          	sub	a0,s1,a0
    800053bc:	00153513          	seqz	a0,a0
    800053c0:	00813483          	ld	s1,8(sp)
    800053c4:	02010113          	addi	sp,sp,32
    800053c8:	00008067          	ret

00000000800053cc <push_off>:
    800053cc:	fe010113          	addi	sp,sp,-32
    800053d0:	00813823          	sd	s0,16(sp)
    800053d4:	00113c23          	sd	ra,24(sp)
    800053d8:	00913423          	sd	s1,8(sp)
    800053dc:	02010413          	addi	s0,sp,32
    800053e0:	100024f3          	csrr	s1,sstatus
    800053e4:	100027f3          	csrr	a5,sstatus
    800053e8:	ffd7f793          	andi	a5,a5,-3
    800053ec:	10079073          	csrw	sstatus,a5
    800053f0:	ffffe097          	auipc	ra,0xffffe
    800053f4:	714080e7          	jalr	1812(ra) # 80003b04 <mycpu>
    800053f8:	07852783          	lw	a5,120(a0)
    800053fc:	02078663          	beqz	a5,80005428 <push_off+0x5c>
    80005400:	ffffe097          	auipc	ra,0xffffe
    80005404:	704080e7          	jalr	1796(ra) # 80003b04 <mycpu>
    80005408:	07852783          	lw	a5,120(a0)
    8000540c:	01813083          	ld	ra,24(sp)
    80005410:	01013403          	ld	s0,16(sp)
    80005414:	0017879b          	addiw	a5,a5,1
    80005418:	06f52c23          	sw	a5,120(a0)
    8000541c:	00813483          	ld	s1,8(sp)
    80005420:	02010113          	addi	sp,sp,32
    80005424:	00008067          	ret
    80005428:	0014d493          	srli	s1,s1,0x1
    8000542c:	ffffe097          	auipc	ra,0xffffe
    80005430:	6d8080e7          	jalr	1752(ra) # 80003b04 <mycpu>
    80005434:	0014f493          	andi	s1,s1,1
    80005438:	06952e23          	sw	s1,124(a0)
    8000543c:	fc5ff06f          	j	80005400 <push_off+0x34>

0000000080005440 <pop_off>:
    80005440:	ff010113          	addi	sp,sp,-16
    80005444:	00813023          	sd	s0,0(sp)
    80005448:	00113423          	sd	ra,8(sp)
    8000544c:	01010413          	addi	s0,sp,16
    80005450:	ffffe097          	auipc	ra,0xffffe
    80005454:	6b4080e7          	jalr	1716(ra) # 80003b04 <mycpu>
    80005458:	100027f3          	csrr	a5,sstatus
    8000545c:	0027f793          	andi	a5,a5,2
    80005460:	04079663          	bnez	a5,800054ac <pop_off+0x6c>
    80005464:	07852783          	lw	a5,120(a0)
    80005468:	02f05a63          	blez	a5,8000549c <pop_off+0x5c>
    8000546c:	fff7871b          	addiw	a4,a5,-1
    80005470:	06e52c23          	sw	a4,120(a0)
    80005474:	00071c63          	bnez	a4,8000548c <pop_off+0x4c>
    80005478:	07c52783          	lw	a5,124(a0)
    8000547c:	00078863          	beqz	a5,8000548c <pop_off+0x4c>
    80005480:	100027f3          	csrr	a5,sstatus
    80005484:	0027e793          	ori	a5,a5,2
    80005488:	10079073          	csrw	sstatus,a5
    8000548c:	00813083          	ld	ra,8(sp)
    80005490:	00013403          	ld	s0,0(sp)
    80005494:	01010113          	addi	sp,sp,16
    80005498:	00008067          	ret
    8000549c:	00001517          	auipc	a0,0x1
    800054a0:	d2450513          	addi	a0,a0,-732 # 800061c0 <digits+0x48>
    800054a4:	fffff097          	auipc	ra,0xfffff
    800054a8:	018080e7          	jalr	24(ra) # 800044bc <panic>
    800054ac:	00001517          	auipc	a0,0x1
    800054b0:	cfc50513          	addi	a0,a0,-772 # 800061a8 <digits+0x30>
    800054b4:	fffff097          	auipc	ra,0xfffff
    800054b8:	008080e7          	jalr	8(ra) # 800044bc <panic>

00000000800054bc <push_on>:
    800054bc:	fe010113          	addi	sp,sp,-32
    800054c0:	00813823          	sd	s0,16(sp)
    800054c4:	00113c23          	sd	ra,24(sp)
    800054c8:	00913423          	sd	s1,8(sp)
    800054cc:	02010413          	addi	s0,sp,32
    800054d0:	100024f3          	csrr	s1,sstatus
    800054d4:	100027f3          	csrr	a5,sstatus
    800054d8:	0027e793          	ori	a5,a5,2
    800054dc:	10079073          	csrw	sstatus,a5
    800054e0:	ffffe097          	auipc	ra,0xffffe
    800054e4:	624080e7          	jalr	1572(ra) # 80003b04 <mycpu>
    800054e8:	07852783          	lw	a5,120(a0)
    800054ec:	02078663          	beqz	a5,80005518 <push_on+0x5c>
    800054f0:	ffffe097          	auipc	ra,0xffffe
    800054f4:	614080e7          	jalr	1556(ra) # 80003b04 <mycpu>
    800054f8:	07852783          	lw	a5,120(a0)
    800054fc:	01813083          	ld	ra,24(sp)
    80005500:	01013403          	ld	s0,16(sp)
    80005504:	0017879b          	addiw	a5,a5,1
    80005508:	06f52c23          	sw	a5,120(a0)
    8000550c:	00813483          	ld	s1,8(sp)
    80005510:	02010113          	addi	sp,sp,32
    80005514:	00008067          	ret
    80005518:	0014d493          	srli	s1,s1,0x1
    8000551c:	ffffe097          	auipc	ra,0xffffe
    80005520:	5e8080e7          	jalr	1512(ra) # 80003b04 <mycpu>
    80005524:	0014f493          	andi	s1,s1,1
    80005528:	06952e23          	sw	s1,124(a0)
    8000552c:	fc5ff06f          	j	800054f0 <push_on+0x34>

0000000080005530 <pop_on>:
    80005530:	ff010113          	addi	sp,sp,-16
    80005534:	00813023          	sd	s0,0(sp)
    80005538:	00113423          	sd	ra,8(sp)
    8000553c:	01010413          	addi	s0,sp,16
    80005540:	ffffe097          	auipc	ra,0xffffe
    80005544:	5c4080e7          	jalr	1476(ra) # 80003b04 <mycpu>
    80005548:	100027f3          	csrr	a5,sstatus
    8000554c:	0027f793          	andi	a5,a5,2
    80005550:	04078463          	beqz	a5,80005598 <pop_on+0x68>
    80005554:	07852783          	lw	a5,120(a0)
    80005558:	02f05863          	blez	a5,80005588 <pop_on+0x58>
    8000555c:	fff7879b          	addiw	a5,a5,-1
    80005560:	06f52c23          	sw	a5,120(a0)
    80005564:	07853783          	ld	a5,120(a0)
    80005568:	00079863          	bnez	a5,80005578 <pop_on+0x48>
    8000556c:	100027f3          	csrr	a5,sstatus
    80005570:	ffd7f793          	andi	a5,a5,-3
    80005574:	10079073          	csrw	sstatus,a5
    80005578:	00813083          	ld	ra,8(sp)
    8000557c:	00013403          	ld	s0,0(sp)
    80005580:	01010113          	addi	sp,sp,16
    80005584:	00008067          	ret
    80005588:	00001517          	auipc	a0,0x1
    8000558c:	c6050513          	addi	a0,a0,-928 # 800061e8 <digits+0x70>
    80005590:	fffff097          	auipc	ra,0xfffff
    80005594:	f2c080e7          	jalr	-212(ra) # 800044bc <panic>
    80005598:	00001517          	auipc	a0,0x1
    8000559c:	c3050513          	addi	a0,a0,-976 # 800061c8 <digits+0x50>
    800055a0:	fffff097          	auipc	ra,0xfffff
    800055a4:	f1c080e7          	jalr	-228(ra) # 800044bc <panic>

00000000800055a8 <__memset>:
    800055a8:	ff010113          	addi	sp,sp,-16
    800055ac:	00813423          	sd	s0,8(sp)
    800055b0:	01010413          	addi	s0,sp,16
    800055b4:	1a060e63          	beqz	a2,80005770 <__memset+0x1c8>
    800055b8:	40a007b3          	neg	a5,a0
    800055bc:	0077f793          	andi	a5,a5,7
    800055c0:	00778693          	addi	a3,a5,7
    800055c4:	00b00813          	li	a6,11
    800055c8:	0ff5f593          	andi	a1,a1,255
    800055cc:	fff6071b          	addiw	a4,a2,-1
    800055d0:	1b06e663          	bltu	a3,a6,8000577c <__memset+0x1d4>
    800055d4:	1cd76463          	bltu	a4,a3,8000579c <__memset+0x1f4>
    800055d8:	1a078e63          	beqz	a5,80005794 <__memset+0x1ec>
    800055dc:	00b50023          	sb	a1,0(a0)
    800055e0:	00100713          	li	a4,1
    800055e4:	1ae78463          	beq	a5,a4,8000578c <__memset+0x1e4>
    800055e8:	00b500a3          	sb	a1,1(a0)
    800055ec:	00200713          	li	a4,2
    800055f0:	1ae78a63          	beq	a5,a4,800057a4 <__memset+0x1fc>
    800055f4:	00b50123          	sb	a1,2(a0)
    800055f8:	00300713          	li	a4,3
    800055fc:	18e78463          	beq	a5,a4,80005784 <__memset+0x1dc>
    80005600:	00b501a3          	sb	a1,3(a0)
    80005604:	00400713          	li	a4,4
    80005608:	1ae78263          	beq	a5,a4,800057ac <__memset+0x204>
    8000560c:	00b50223          	sb	a1,4(a0)
    80005610:	00500713          	li	a4,5
    80005614:	1ae78063          	beq	a5,a4,800057b4 <__memset+0x20c>
    80005618:	00b502a3          	sb	a1,5(a0)
    8000561c:	00700713          	li	a4,7
    80005620:	18e79e63          	bne	a5,a4,800057bc <__memset+0x214>
    80005624:	00b50323          	sb	a1,6(a0)
    80005628:	00700e93          	li	t4,7
    8000562c:	00859713          	slli	a4,a1,0x8
    80005630:	00e5e733          	or	a4,a1,a4
    80005634:	01059e13          	slli	t3,a1,0x10
    80005638:	01c76e33          	or	t3,a4,t3
    8000563c:	01859313          	slli	t1,a1,0x18
    80005640:	006e6333          	or	t1,t3,t1
    80005644:	02059893          	slli	a7,a1,0x20
    80005648:	40f60e3b          	subw	t3,a2,a5
    8000564c:	011368b3          	or	a7,t1,a7
    80005650:	02859813          	slli	a6,a1,0x28
    80005654:	0108e833          	or	a6,a7,a6
    80005658:	03059693          	slli	a3,a1,0x30
    8000565c:	003e589b          	srliw	a7,t3,0x3
    80005660:	00d866b3          	or	a3,a6,a3
    80005664:	03859713          	slli	a4,a1,0x38
    80005668:	00389813          	slli	a6,a7,0x3
    8000566c:	00f507b3          	add	a5,a0,a5
    80005670:	00e6e733          	or	a4,a3,a4
    80005674:	000e089b          	sext.w	a7,t3
    80005678:	00f806b3          	add	a3,a6,a5
    8000567c:	00e7b023          	sd	a4,0(a5)
    80005680:	00878793          	addi	a5,a5,8
    80005684:	fed79ce3          	bne	a5,a3,8000567c <__memset+0xd4>
    80005688:	ff8e7793          	andi	a5,t3,-8
    8000568c:	0007871b          	sext.w	a4,a5
    80005690:	01d787bb          	addw	a5,a5,t4
    80005694:	0ce88e63          	beq	a7,a4,80005770 <__memset+0x1c8>
    80005698:	00f50733          	add	a4,a0,a5
    8000569c:	00b70023          	sb	a1,0(a4)
    800056a0:	0017871b          	addiw	a4,a5,1
    800056a4:	0cc77663          	bgeu	a4,a2,80005770 <__memset+0x1c8>
    800056a8:	00e50733          	add	a4,a0,a4
    800056ac:	00b70023          	sb	a1,0(a4)
    800056b0:	0027871b          	addiw	a4,a5,2
    800056b4:	0ac77e63          	bgeu	a4,a2,80005770 <__memset+0x1c8>
    800056b8:	00e50733          	add	a4,a0,a4
    800056bc:	00b70023          	sb	a1,0(a4)
    800056c0:	0037871b          	addiw	a4,a5,3
    800056c4:	0ac77663          	bgeu	a4,a2,80005770 <__memset+0x1c8>
    800056c8:	00e50733          	add	a4,a0,a4
    800056cc:	00b70023          	sb	a1,0(a4)
    800056d0:	0047871b          	addiw	a4,a5,4
    800056d4:	08c77e63          	bgeu	a4,a2,80005770 <__memset+0x1c8>
    800056d8:	00e50733          	add	a4,a0,a4
    800056dc:	00b70023          	sb	a1,0(a4)
    800056e0:	0057871b          	addiw	a4,a5,5
    800056e4:	08c77663          	bgeu	a4,a2,80005770 <__memset+0x1c8>
    800056e8:	00e50733          	add	a4,a0,a4
    800056ec:	00b70023          	sb	a1,0(a4)
    800056f0:	0067871b          	addiw	a4,a5,6
    800056f4:	06c77e63          	bgeu	a4,a2,80005770 <__memset+0x1c8>
    800056f8:	00e50733          	add	a4,a0,a4
    800056fc:	00b70023          	sb	a1,0(a4)
    80005700:	0077871b          	addiw	a4,a5,7
    80005704:	06c77663          	bgeu	a4,a2,80005770 <__memset+0x1c8>
    80005708:	00e50733          	add	a4,a0,a4
    8000570c:	00b70023          	sb	a1,0(a4)
    80005710:	0087871b          	addiw	a4,a5,8
    80005714:	04c77e63          	bgeu	a4,a2,80005770 <__memset+0x1c8>
    80005718:	00e50733          	add	a4,a0,a4
    8000571c:	00b70023          	sb	a1,0(a4)
    80005720:	0097871b          	addiw	a4,a5,9
    80005724:	04c77663          	bgeu	a4,a2,80005770 <__memset+0x1c8>
    80005728:	00e50733          	add	a4,a0,a4
    8000572c:	00b70023          	sb	a1,0(a4)
    80005730:	00a7871b          	addiw	a4,a5,10
    80005734:	02c77e63          	bgeu	a4,a2,80005770 <__memset+0x1c8>
    80005738:	00e50733          	add	a4,a0,a4
    8000573c:	00b70023          	sb	a1,0(a4)
    80005740:	00b7871b          	addiw	a4,a5,11
    80005744:	02c77663          	bgeu	a4,a2,80005770 <__memset+0x1c8>
    80005748:	00e50733          	add	a4,a0,a4
    8000574c:	00b70023          	sb	a1,0(a4)
    80005750:	00c7871b          	addiw	a4,a5,12
    80005754:	00c77e63          	bgeu	a4,a2,80005770 <__memset+0x1c8>
    80005758:	00e50733          	add	a4,a0,a4
    8000575c:	00b70023          	sb	a1,0(a4)
    80005760:	00d7879b          	addiw	a5,a5,13
    80005764:	00c7f663          	bgeu	a5,a2,80005770 <__memset+0x1c8>
    80005768:	00f507b3          	add	a5,a0,a5
    8000576c:	00b78023          	sb	a1,0(a5)
    80005770:	00813403          	ld	s0,8(sp)
    80005774:	01010113          	addi	sp,sp,16
    80005778:	00008067          	ret
    8000577c:	00b00693          	li	a3,11
    80005780:	e55ff06f          	j	800055d4 <__memset+0x2c>
    80005784:	00300e93          	li	t4,3
    80005788:	ea5ff06f          	j	8000562c <__memset+0x84>
    8000578c:	00100e93          	li	t4,1
    80005790:	e9dff06f          	j	8000562c <__memset+0x84>
    80005794:	00000e93          	li	t4,0
    80005798:	e95ff06f          	j	8000562c <__memset+0x84>
    8000579c:	00000793          	li	a5,0
    800057a0:	ef9ff06f          	j	80005698 <__memset+0xf0>
    800057a4:	00200e93          	li	t4,2
    800057a8:	e85ff06f          	j	8000562c <__memset+0x84>
    800057ac:	00400e93          	li	t4,4
    800057b0:	e7dff06f          	j	8000562c <__memset+0x84>
    800057b4:	00500e93          	li	t4,5
    800057b8:	e75ff06f          	j	8000562c <__memset+0x84>
    800057bc:	00600e93          	li	t4,6
    800057c0:	e6dff06f          	j	8000562c <__memset+0x84>

00000000800057c4 <__memmove>:
    800057c4:	ff010113          	addi	sp,sp,-16
    800057c8:	00813423          	sd	s0,8(sp)
    800057cc:	01010413          	addi	s0,sp,16
    800057d0:	0e060863          	beqz	a2,800058c0 <__memmove+0xfc>
    800057d4:	fff6069b          	addiw	a3,a2,-1
    800057d8:	0006881b          	sext.w	a6,a3
    800057dc:	0ea5e863          	bltu	a1,a0,800058cc <__memmove+0x108>
    800057e0:	00758713          	addi	a4,a1,7
    800057e4:	00a5e7b3          	or	a5,a1,a0
    800057e8:	40a70733          	sub	a4,a4,a0
    800057ec:	0077f793          	andi	a5,a5,7
    800057f0:	00f73713          	sltiu	a4,a4,15
    800057f4:	00174713          	xori	a4,a4,1
    800057f8:	0017b793          	seqz	a5,a5
    800057fc:	00e7f7b3          	and	a5,a5,a4
    80005800:	10078863          	beqz	a5,80005910 <__memmove+0x14c>
    80005804:	00900793          	li	a5,9
    80005808:	1107f463          	bgeu	a5,a6,80005910 <__memmove+0x14c>
    8000580c:	0036581b          	srliw	a6,a2,0x3
    80005810:	fff8081b          	addiw	a6,a6,-1
    80005814:	02081813          	slli	a6,a6,0x20
    80005818:	01d85893          	srli	a7,a6,0x1d
    8000581c:	00858813          	addi	a6,a1,8
    80005820:	00058793          	mv	a5,a1
    80005824:	00050713          	mv	a4,a0
    80005828:	01088833          	add	a6,a7,a6
    8000582c:	0007b883          	ld	a7,0(a5)
    80005830:	00878793          	addi	a5,a5,8
    80005834:	00870713          	addi	a4,a4,8
    80005838:	ff173c23          	sd	a7,-8(a4)
    8000583c:	ff0798e3          	bne	a5,a6,8000582c <__memmove+0x68>
    80005840:	ff867713          	andi	a4,a2,-8
    80005844:	02071793          	slli	a5,a4,0x20
    80005848:	0207d793          	srli	a5,a5,0x20
    8000584c:	00f585b3          	add	a1,a1,a5
    80005850:	40e686bb          	subw	a3,a3,a4
    80005854:	00f507b3          	add	a5,a0,a5
    80005858:	06e60463          	beq	a2,a4,800058c0 <__memmove+0xfc>
    8000585c:	0005c703          	lbu	a4,0(a1)
    80005860:	00e78023          	sb	a4,0(a5)
    80005864:	04068e63          	beqz	a3,800058c0 <__memmove+0xfc>
    80005868:	0015c603          	lbu	a2,1(a1)
    8000586c:	00100713          	li	a4,1
    80005870:	00c780a3          	sb	a2,1(a5)
    80005874:	04e68663          	beq	a3,a4,800058c0 <__memmove+0xfc>
    80005878:	0025c603          	lbu	a2,2(a1)
    8000587c:	00200713          	li	a4,2
    80005880:	00c78123          	sb	a2,2(a5)
    80005884:	02e68e63          	beq	a3,a4,800058c0 <__memmove+0xfc>
    80005888:	0035c603          	lbu	a2,3(a1)
    8000588c:	00300713          	li	a4,3
    80005890:	00c781a3          	sb	a2,3(a5)
    80005894:	02e68663          	beq	a3,a4,800058c0 <__memmove+0xfc>
    80005898:	0045c603          	lbu	a2,4(a1)
    8000589c:	00400713          	li	a4,4
    800058a0:	00c78223          	sb	a2,4(a5)
    800058a4:	00e68e63          	beq	a3,a4,800058c0 <__memmove+0xfc>
    800058a8:	0055c603          	lbu	a2,5(a1)
    800058ac:	00500713          	li	a4,5
    800058b0:	00c782a3          	sb	a2,5(a5)
    800058b4:	00e68663          	beq	a3,a4,800058c0 <__memmove+0xfc>
    800058b8:	0065c703          	lbu	a4,6(a1)
    800058bc:	00e78323          	sb	a4,6(a5)
    800058c0:	00813403          	ld	s0,8(sp)
    800058c4:	01010113          	addi	sp,sp,16
    800058c8:	00008067          	ret
    800058cc:	02061713          	slli	a4,a2,0x20
    800058d0:	02075713          	srli	a4,a4,0x20
    800058d4:	00e587b3          	add	a5,a1,a4
    800058d8:	f0f574e3          	bgeu	a0,a5,800057e0 <__memmove+0x1c>
    800058dc:	02069613          	slli	a2,a3,0x20
    800058e0:	02065613          	srli	a2,a2,0x20
    800058e4:	fff64613          	not	a2,a2
    800058e8:	00e50733          	add	a4,a0,a4
    800058ec:	00c78633          	add	a2,a5,a2
    800058f0:	fff7c683          	lbu	a3,-1(a5)
    800058f4:	fff78793          	addi	a5,a5,-1
    800058f8:	fff70713          	addi	a4,a4,-1
    800058fc:	00d70023          	sb	a3,0(a4)
    80005900:	fec798e3          	bne	a5,a2,800058f0 <__memmove+0x12c>
    80005904:	00813403          	ld	s0,8(sp)
    80005908:	01010113          	addi	sp,sp,16
    8000590c:	00008067          	ret
    80005910:	02069713          	slli	a4,a3,0x20
    80005914:	02075713          	srli	a4,a4,0x20
    80005918:	00170713          	addi	a4,a4,1
    8000591c:	00e50733          	add	a4,a0,a4
    80005920:	00050793          	mv	a5,a0
    80005924:	0005c683          	lbu	a3,0(a1)
    80005928:	00178793          	addi	a5,a5,1
    8000592c:	00158593          	addi	a1,a1,1
    80005930:	fed78fa3          	sb	a3,-1(a5)
    80005934:	fee798e3          	bne	a5,a4,80005924 <__memmove+0x160>
    80005938:	f89ff06f          	j	800058c0 <__memmove+0xfc>
	...
