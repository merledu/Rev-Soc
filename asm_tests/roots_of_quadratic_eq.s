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


//aX^2+bX+c
li s0,1 //   a = 1 INPUT   tested equations (x^2-15x+56 expected results 8 and 7 )  and  (x^2+5x-14 expected results 2 and -7) 
li s1,5 // b = 5 INPUT
li s2,-14 //  c = -14 INPUT
li t4,4
li t5,0
li s3,200


mul t0,s1,s1 // t0 = b^2
mul t1,s0,s2 // t1 = a*c
mul t1,t1,t4 // t1 = 4*a*c

sub t2,t0,t1 // t2 = b^2-4*a*c

Perfect_square:
bgt t5,s3,END
addi t5,t5,1
mul t6,t5,t5 // t6 = t5^2
blt t6,t2,Perfect_square

li t4,0 
sub t0,t4,s1  // t0 = -b
add t1,t0,t5  // t1 = -b+(b^2-4*a*c)^(1/2)
sub t2,t0,t5  // t1 = -b-(b^2-4*a*c)^(1/2)
li s4,2
mul t4,s4,s0 // t4 = 2*a
div s0,t1,t4 // t1 = (-b+(b^2-4*a*c)^(1/2))/(2*a)
div s1,t2,t4 // t1 = (b-b^2-4*a*c)^(1/2))/(2*a)

li s5,0xf0040000  // Memory base adress

sw s0,0(s5)  // Storing first root
addi s5,s5,4 // increment word adress
sw s1,0(s5)  // Storing second root

li s5,STDOUT

sw s0,0(s5)  // Storing first root to tb
addi s5,s5,4 // increment word adress 
sw s1,0(s5)  // Storing second root tb



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
