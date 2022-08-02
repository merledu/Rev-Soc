#include "defines.h"
#define STDOUT     0xd0580000
// Code to execute
.section .text
.global _start
_start:

li x1, 3
li x2 , 1
add x3,x1,x2
