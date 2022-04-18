#include "defines.h"

#define STDOUT 0xd0580000

// Code to execute
.section .text
.global _start
_start:

//Prime numbers in a given range 

// li x1, 0x5f555555
// csrw 0x7c0, x1

csrw minstret, zero
csrw minstreth, zero
 
//li x4, 4        // Neccessary for terminating code
//csrw 0x7f9 ,x4  // Neccessary for terminating code



li s0,4789884  //Number to reverse INPUT Expected output should be 4889874 in decimal or 4A9D12 in HEX
li s1,7        // length of number INPUT
li t0,10       //constant     
li t4,4    
li s2,0xf0040000    //base adress
mul t3,s1,t4
add t3,t3,s2
sub t3,t3,t4
sub s2,s2,t4
addi s4,t3,0
li t1,2

LOOP:
beqz t1,ORDER
div t1,s0,t0
rem t2,s0,t0
addi s0,t1,0

sb t2,0(t3)
sub t3,t3,t4
j LOOP


ORDER:
mul t6,t6,t0
lb t5,0(s4)
sub s4,s4,t4
add t6,t6,t5

bne s2,s4,ORDER


END:
li t0,STDOUT
sw t6,0(t0)

// Write 0xff to STDOUT for TB to termiate test.
_finish:
    li x3, STDOUT
    addi x5, x0, 0xff
    sb x5, 0(x3)
    beq x0, x0, _finish
.rept 100
    nop
.endr
