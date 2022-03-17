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
 
li x4, 4        // Neccessary for terminating code
csrw 0x7f9 ,x4  // Neccessary for terminating code


//Multiplication table
li s0,5 // Number for table generation: INPUT  expected result= 5 10 15 20 25 30
li s1,6 // Number of times of table:   INPUT
li t1,0 // counter i
li t2,0xf0040000 // memory base adress
li t3,STDOUT 

LOOP:
addi t1,t1,1 // i++
mul t0,s0,t1 // t0=4*i
sw t0,0(t2)  // store t0
sw t0,0(t3)  // store t0 to tb
addi t2,t2,4 // increment word adress
addi t3,t3,4 // increment word adress
bne t1,s1,LOOP

END:



// Write 0xff to STDOUT for TB to termiate test.
_finish:
    li x3, STDOUT
    addi x5, x0, 0xff
    sb x5, 0(x3)
    beq x0, x0, _finish
.rept 100
    nop
.endr
