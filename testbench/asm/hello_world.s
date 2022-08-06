// SPDX-License-Identifier: Apache-2.0
// Copyright 2019 Western Digital Corporation or its affiliates.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

// Assembly code for Hello World
// Not using only ALU ops for creating the string


#include "defines.h"

#define STDOUT 0xd0580000


// Code to execute
.section .text
.global _start
_start:

    li x1,0x40866666
    fmv.s.x f1,x1
    li x2,0x4089999a
    fmv.s.x f2,x2
    fadd.s f3,f1,f2
    li x3,0x41080000
    fmv.s.x f4,x3
    feq.s x4,f3,f4

// Write 0xff to STDOUT for TB to termiate test.
_finish:
    li x3, STDOUT
    addi x5, x0, 0x1
    sb x5, 0(x3)
    beq x0, x0, _finish
.rept 100
    nop
.endr

//.data
//hw_data:
//.ascii "----------------------------------\n"
//.ascii "Hello World from SweRV EL2 @WDC !!\n"
//.ascii "----------------------------------\n"
//.byte 0
