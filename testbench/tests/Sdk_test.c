/*  ....................................................................................*/
/* .MMMMMMM.......MMMMMMM....EEEEEEEEEEEEEEEEE...RRRRRRRRRRRRRRRR.....RLLLLL............*/
/* .MMMMMMM.......MMMMMMM....EEEEEEEEEEEEEEEEE...RRRRRRRRRRRRRRRRR....RLLLLL............*/
/* .MMMMMMM.......MMMMMMM....EEEEEEEEEEEEEEEEE...RRRRRRRRRRRRRRRRRR...RLLLLL............*/
/* .MMMMMMMM.....MMMMMMMM....EEEEEEEEEEEEEEEEE...RRRRRRRRRRRRRRRRRR...RLLLLL............*/
/* .MMMMMMMM.....MMMMMMMM....EEEEE...............RRRRR.......RRRRRR...RLLLLL............*/
/* .MMMMMMMM.....MMMMMMMM....EEEEE...............RRRRR........RRRRRR..RLLLLL............*/
/* .MMMMMMMMM....MMMMMMMM....EEEEE...............RRRRR........RRRRR...RLLLLL............*/
/* .MMMMMMMMM...MMMMMMMMM....EEEEE...............RRRRR.......RRRRRR...RLLLLL............*/
/* .MMMM.MMMM...MMMM.MMMM....EEEEEEEEEEEEEEEE....RRRRR.....RRRRRRRR...RLLLLL............*/
/* .MMMM.MMMMM..MMMM.MMMM....EEEEEEEEEEEEEEEE....RRRRRRRRRRRRRRRRRR...RLLLLL............*/
/* .MMMM.MMMMM.MMMMM.MMMM....EEEEEEEEEEEEEEEE....RRRRRRRRRRRRRRRRR....RLLLLL............*/
/* .MMMM..MMMM.MMMM..MMMM....EEEEEEEEEEEEEEEE....RRRRRRRRRRRRRRR......RLLLLL............*/
/* .MMMM..MMMM.MMMM..MMMM....EEEEE...............RRRRRRRRRRRRRRR......RLLLLL............*/
/* .MMMM..MMMMMMMMM..MMMM....EEEEE...............RRRRR....RRRRRRR.....RLLLLL............*/
/* .MMMM...MMMMMMM...MMMM....EEEEE...............RRRRR.....RRRRRR.....RLLLLL............*/
/* .MMMM...MMMMMMM...MMMM....EEEEE...............RRRRR......RRRRRR....RLLLLL............*/
/* .MMMM...MMMMMMM...MMMM....EEEEEEEEEEEEEEEEE...RRRRR......RRRRRRR...RLLLLLLLLLLLLLLL..*/
/* .MMMM....MMMMM....MMMM....EEEEEEEEEEEEEEEEE...RRRRR.......RRRRRR...RLLLLLLLLLLLLLLL..*/
/* .MMMM....MMMMM....MMMM....EEEEEEEEEEEEEEEEE...RRRRR........RRRRRR..RLLLLLLLLLLLLLLL..*/
/* .MMMM....MMMMM....MMMM....EEEEEEEEEEEEEEEEE...RRRRR........RRRRRR..RLLLLLLLLLLLLLLL..*/
/* .....................................................................................*/
/* .....................................................................................*/
/* ........................by(Micro Electronics Research Lab)...........................*/
/* .....................................................................................*/
#include "timer.h"
#include "Timer.c"
#include "gpio.h"
#include "GPIO.c"
#include "pwm.h"
#include "PWM.c"
#include "uart_header.h"
#include "uart.c"
/******************************************************************///////
/*SDK Enviorinment ReV-SoC (System On Chip)************************///////
/*BY Micro Electronics Lab (MERL) UIT *****************************///////
/******************************************************************///////
/*Implemented Drivers *********************************************///////
/******************************************************************///////
/*Timer delay(DelayInMiliSeconds);*********************************///////
/*GPIO digitalWrite(GPIO_Pin_values)*******************************///////
/*PWM pwm(dutyCycle, Period )**************************************///////
/*UART uartTx(baudrate, clkfreq, byte1,byte2,...byte8)*************///////
/******************************************************************///////
//////////////////////////////////////////////////////////////////////////

///////////////////////MAIN PROGRAM GOES HERE/////////////////////////////

// GPIO BLINK WITHOUT TIMER
// int main() {
// int a,b,c,d,e=10;
// // GPIO BLINK without interrupt
//   while(e!=0){
//   d = 2;
//   digitalWrite(1);
//   while(d<200000){
//     a = b+c;
//     b++;
//     c++;
//     d++;
//   }
//   d = 2;
//   digitalWrite(0);
  
//   while(d<200000){
//     a = b+c;
//     b++;
//     c++;
//     d++;
//   }
//   }
//   return 0;
// }


// GPIO BLINK WITH TIMER GENERATED DELAY WITH INTERRUPT
// int main(){
//   int f = 10;
//   while (f!=0){      // Infinite LOOP
//     digitalWrite(0); // All GPIOs Set to Zero LEDs OFF
//     delay(200);      // 200ms Delay from timer
//     digitalWrite(1); // GPIO 1 Set to HIGH LED ON
//     delay(200);
//     digitalWrite(2); // GPIO 1 and 2 set High 
//     delay(200);
//     digitalWrite(3); // GPIO 1,2 and 3 set High 
//     delay(200);
//     digitalWrite(0); // All GPIOs Set to Zero LEDs OFF
//     delay(200);
//     digitalWrite(2); 
//     delay(200);
//     digitalWrite(3);
//     delay(200); // This LED chasing combination LOOPs
//   }
//   return 0;
// }




// // Timer GPIO and PWM with interrupts
// int main(){
//   int f = 10, i = 0; // Variable declaration for infinite LOOP
// //////////////////////////////////////////////////////////////////////////  
//   while (f!=0){      // Infinite LOOP
//     if(i<100)        // duty cycle reset condition
//       i=i+20;        // Variable Duty cycle increments by 20 per iteration
//     else 
//       i=0;
//     digitalWrite(0); // All GPIOs Set to Zero LEDs OFF
//     delay(1000);      // 200ms Delay from timer
//     digitalWrite(1); // GPIO 1 Set to HIGH LED ON
//     delay(1000);
//     digitalWrite(2); // GPIO 1 and 2 set High 
//     delay(1000);
//     digitalWrite(3); // GPIO 1,2 and 3 set High 
//     delay(1000);
//     digitalWrite(0); // All GPIOs Set to Zero LEDs OFF
//     delay(1000);
//     digitalWrite(2); 
//     delay(1000);
//     pwm(i,100);
//     digitalWrite(3);
//     delay(1000); // This LED chasing combination LOOPs
//   }
//   return 0;
// }




//  //// GPIO interrupt based Decision of LED
// int main(){
//   int f = 6,b=0;
//   while (f!=0){      // Infinite LOOP
//   b = Gpiointerrupt();
//   digitalWrite(b);
//   delay(1);
//   }
//   return 0;
// }



//  //// GPIO 0 on
// int main(){
//   int f = 6;
//   digitalWrite(1);
//   //delay(1000);
  
//   return 0;
// }


 //// GPIO 1 on
// int main(){
//   int f = 6;
//   digitalWrite(2);
//   //delay(1000);
  
//   return 0;
// }


//  //// GPIO OFF
// int main(){
//   int f = 6;
//   digitalWrite(0);
//   //delay(1000);
  
//   return 0;
// }


// GPIO 1 Second Blink
// int main(){
//   int f = 10;
//   while (f!=0){      // Infinite LOOP
//     digitalWrite(0); // All GPIOs Set to Zero LEDs OFF
//     delay(500);      // 200ms Delay from timer
//     digitalWrite(1); // GPIO 1 Set to HIGH LED ON
//     delay(500);}
//   return 0; 
// }


// // Uart test

// int main(){

//   uartTx(115200, 2500000, 0x52, 0x20, 0x52, 0x20, 0x52, 0x20, 0x52);
//   // delay(1000);
//   return 0;
// }























// // UART SEND STRING
// int main(){
//   int f = 6,b=0,c=2;
//   char str = "ReV-SoC";
//   uartTx(115200,2500000,str);
//   while(c!=1){
//   c++;}

//   return 0;
// }

