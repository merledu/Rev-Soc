# 1 "/home/wishah/Downloads/Rev-Soc/testbench/asm/hello_world.s"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "/home/wishah/Downloads/Rev-Soc/testbench/asm/hello_world.s"
# 21 "/home/wishah/Downloads/Rev-Soc/testbench/asm/hello_world.s"
# 1 "snapshots/default/defines.h" 1
# 22 "/home/wishah/Downloads/Rev-Soc/testbench/asm/hello_world.s" 2





.section .text
.global _start
_start:

    li t1,3
    li t2,7
    li t3,2
    FCVT.S.W f1,t1
    FCVT.S.W f2,t2
    FCVT.S.W f3,t3
    flt.s t5,f1,f4


_finish:
    li x3, 0xd0580000
    addi x5, x0, 0x1
    sb x5, 0(x3)
    beq x0, x0, _finish
.rept 100
    nop
.endr
