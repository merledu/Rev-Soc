/////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company:       MICRO-ELECTRONICS RESEARCH LABORATORY                                                //
//                                                                                                     //
// Engineers:     Rehan Ejaz - Design Engineer                                                         //
//                                                                                                     //
// Additional contributions by:                                                                        //
//                                                                                                     //
// Create Date:   18.04.2022                                                                           //
// Design Name:   Timer test                                                                           //
// Project Name:  ReV-SoC                                                                              //
// Language:      SystemVerilog -                                                                      //
//                                                                                                     //
// Description:                                                                                        //
//  This is a simple C language testbench to configure timer by using the assmebler function           //
//                                                                                                     //
//                                                                                                     //
// Revision Date:                                                                                      //
//                                                                                                     //
/////////////////////////////////////////////////////////////////////////////////////////////////////////
#include <stdbool.h>
#include <stdint.h>
#include "timer.h"
#include "Timer.c"
#include "gpio.h"
#include "GPIO.c"

#define STACK 0x70041
int main() {
   float a = 4.2,b=4.3, d = 8.5;
   float c;
   c = a + b;
   if(c == d)
   digitalWrite(1);
   else
   digitalWrite(0);
   // delay(200);
   return 0;
}