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

// Assembly code for SPI Testing
// Not using only ALU ops for creating the string


#include "defines.h"
#define TIMER_BASE           0x20002000
#define GPIO_BASE            0x20004000
#define SPI_BASE             0x20006000
#define PWM_BASE             0x20008000
//#define UART_BASE            0x2000A000
//#define I2C_BASE             0x2000E000


#define STDOUT     0xd0580000
#define CLK_DIV    0x4
#define LENGTH_REG 0x10
#define CMD_REG    0x8
#define ADDR_REG   0xC
#define DUMMY_CYC  0x14
#define DATA_REG   0x18
#define STATUS_REG 0x00

// Code to execute
.section .text
.global _start
_start:
// Setting CLK divider to 0
li t0,SPI_BASE
li t1,0x0
sw t1,CLK_DIV(t0)

// Setting length register

li t2,0x202008  // PWDATA  = {16'd32,2'd0,6'd32,2'd0,6'd8}; // 32 bit data 32 bit address 8 bit command 
sw t2,LENGTH_REG(t0)  // PADDR   = 12'h10; data written

//Setting command to 1
li t1,0x1
sw t1,CMD_REG(t0)


// Setting address to F or 15 in decimal
li t2,0x0000000F
sw t2,ADDR_REG(t0)

// Setting Dummy read and write cycle count to 8 each
li t2,0x80008
sw t2,DUMMY_CYC(t0)

// Setting data to write in FIFO register
li t2,0xAAAAAAAA
sw t2,DATA_REG(t0)

// Enabling the standard mode data Transfer from SPI master
li t2,0x102
sw t2,STATUS_REG(t0)

LOOP:
li t3,0x67
j LOOP
