#include "defines.h"
#define STDOUT     0xd0580000
// Code to execute
.section .text
.global _start
_start:

loop:
    lb x5, 0(x4)
    sb x5, 0(x3)
    addi x4, x4, 1
    li x6, 0xdeadbeef
    li x7, 0xf004f000
    fmv.s.x f6,x6
    fmv.s.x f7,x7
    li x8,8
    li x9,14
    extract_data:
    addi x9,x9,-1
    fsw f6, 0(x7)
    flw f8, 0(x7)   
    addi x7,x7,4
    bne x8,x9, extract_data
    li x10, 0xf00400ff
    fsw f6,0(x10)
 	addi	sp,sp,-32
 	sw	s0,28(sp)
 	addi	s0,sp,32
 	li	a5,1
sw	a5,-20(s0)
lui	a5,0xf0040
flw	fa5,0(a5) # f0040000 <STACK+0xffffeff0>
fsw	fa5,-24(s0)
lui	a5,0xf0040
flw	fa5,4(a5) # f0040004 <STACK+0xffffeff4>
fsw	fa5,-28(s0)
lui	a5,0xf0040
flw	fa5,8(a5) # f0040008 <STACK+0xffffeff8>
fsw	fa5,-32(s0)
li	a5,100
sw	a5,-20(s0)
sw	zero,-20(s0)
 	li	a5,0
 	mv	a0,a5
 	lw	s0,28(sp)
 	addi	sp,sp,32
 	ret




    bnez x5, loop

    // Write 0xff to STDOUT for TB to termiate test.
_finish:
    li x3, STDOUT
    addi x5, x0, 0x1
    sb x5, 0(x3)
    beq x0, x0, _finish
.rept 100
    nop
.endr