#include "defines.h"
#define STDOUT     0xd0580000
// Code to execute
.section .text
.global _start
_start:

addi	sp,sp,-32
sw	s0,28(sp)
addi	s0,sp,32
lui	a5,0xd0580
sw	a5,-20(s0)
lw	a5,-20(s0)
li	a4,255	
sw	a4,0(a5) # d0580000 <STACK+0xe053f000>
sw	zero,-24(s0)
sw	zero,-24(s0)
sw	zero,-24(s0)
li	a5,0
mv	a0,a5
lw	s0,28(sp)
addi	sp,sp,32
ret
