/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company: MICRO-ELECTRONICS RESEARCH LABORATORY //
// //
// Engineer: Wishah Naseer - Hardware Designer //
// //
// Additional contributions by: Rehan Ejaz, M. Uzair Qureshi//
// //
// Create Date: 01-MARCH-2022 //
// Design Name: Assembly Code For PWM Testing //
// Module Name: pwm_tb.s //
// Project Name: ReV-SoC //
// Language: Assembly //
// //
// Description: Pulse width modulation (PWM) is a modulation technique that generates 
// variable-width pulses to represent the amplitude of an analog input signal.//
// //
// //
// Revision Date: //
// //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


#include "defines.h"

#define adr_ctrl_1	 	0x0
#define	adr_divisor_1 	0x4
#define adr_period_1	0x8
#define adr_DC_1		0xc

#define STDOUT     0xd0580000
#define TIMER_BASE           0x20002000
#define GPIO_BASE            0x20004000
#define SPI_BASE             0x20006000
#define PWM_BASE             0x20008000
//#define UART_BASE            0x2000A000
//#define I2C_BASE             0x2000E000


// Code to execute
.section .text
.global _start
_start:

// Setting Clk divisor to 2
li t0,PWM_BASE
li t1,0x2
sw t1,adr_divisor_1(t0)

// Setting period
li t2,0xA
sw t2,adr_period_1(t0)  

// Setting DC
li t1,0x6
sw t1,adr_DC_1(t0)


// Granting Control To Channel 01
li t2,0x7
sw t2,adr_ctrl_1(t0)

LOOP:
addi t0,t1,2
li t0,1
li t1,STDOUT
sw t0,0(t1)
