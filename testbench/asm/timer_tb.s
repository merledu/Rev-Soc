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

// Assembly code for TIMER Testing
// Not using only ALU ops for creating the string

// Peripheral Base Adresses for connecting new timer

//0010000000000000 0x2000
//0100000000000000 0x4000
//0110000000000000 0x6000
//1000000000000000 0x8000
//1010000000000000 0xA000
//1100000000000000 0xC000
//1110000000000000 0xE000

#include "defines.h"
#define STDOUT     0xd0580000

#define TIMER_BASE           0x20002000
#define PWM_BASE             0x20004000
#define UART_BASE            0x20006000
#define GPIO_BASE            0x20008000
#define SPI_BASE             0x2000A000
#define I2C_BASE             0x2000E000
// Register adresses
#define CTRL                0x0
#define CFG                 0x100
#define TIMER_L             0x104
#define TIMER_U             0x108
#define CMP_L               0x10c
#define CMP_U               0x110
#define INTR_EN             0x114
// Configurations 
#define PRESCALER_0_DISABLED 0x0
#define PRESCALER_1_DISABLED 0x8
#define PRESCALER_2_DISABLED 0x10
#define PRESCALER_3_DISABLED 0x18
#define PRESCALER_4_DISABLED 0x20
#define PRESCALER_5_DISABLED 0x28
#define PRESCALER_6_DISABLED 0x30
#define PRESCALER_7_DISABLED 0x38
#define PRESCALER_0_ENABLED  0x1
#define PRESCALER_1_ENABLED  0x9
#define PRESCALER_2_ENABLED  0x11
#define PRESCALER_3_ENABLED  0x19
#define PRESCALER_4_ENABLED  0x21
#define PRESCALER_5_ENABLED  0x29
#define PRESCALER_6_ENABLED  0x31
#define PRESCALER_7_ENABLED  0x39rst
#define MAX_CMP              0xFFFF_FFFF
         

// Code to execute
.section .text
.global _start
_start:


// Setting CTRL disable  by writing 0

li t0,TIMER_BASE
li t1,0x0
sw t1,CTRL(t0)

// Setting prescaler to zero step to 1
li t0,TIMER_BASE
li t1,0x20001
sw t1,CFG(t0)

// Setting timer lower reg  to 0x0

li t1,0
sw t1,TIMER_L(t0)

// Setting timer upper reg  to 0x0

li t1,0
sw t1,TIMER_U(t0)


// Setting Compare lower reg  to 10

li t1,10
sw t1,CMP_L(t0)

// Setting Compare UPPER reg  to 0

li t1,0x0
sw t1,CMP_U(t0)


// Setting interrupt enable  by writing INTR_EN

li t0,TIMER_BASE
li t1,0x1
sw t1,INTR_EN(t0)

// Setting CTRL enable  by writing 1

li t0,TIMER_BASE
li t1,0x1
sw t1,CTRL(t0)



// LOOP
LOOP:

addi t5,t5,1
j LOOP


