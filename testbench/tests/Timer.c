#include "timer.h"
// #include "gpio.h"
// #include "GPIO.c"
// #include "pwm.h"
// #include "PWM.c"

#include <stdbool.h>
#include <stdint.h>


void delay(int a)
{

int *time_cmp_l, *time_cmp_u, *ctrl, *prescale, *ie, *time_l, *time_u; // Pointer declaration
// Disabling timer by writing zero to the control register
ctrl = (int*)(TIMER_BASE_ADDRESS + CTRL);
*ctrl = 0;

time_l = (int*)(TIMER_BASE_ADDRESS + TIMER_L);
*time_l = 0;

time_u = (int*)(TIMER_BASE_ADDRESS + TIMER_U);
*time_u = 0;

// Setting prescale to zero and step to 1
prescale = (int*)(TIMER_BASE_ADDRESS + CFG);
*prescale = 0x20001;

// Setting timer lower reg to the given delay
time_cmp_l = (int*)(TIMER_BASE_ADDRESS + CMP_L);
*time_cmp_l = a*2500;

// Setting timer Upper reg to zero
time_cmp_u = (int*)(TIMER_BASE_ADDRESS + CMP_U);
*time_cmp_u = 0;

// Setting interrupt enable by writing 1
ie = (int*)(TIMER_BASE_ADDRESS + INTR_EN);
*ie = 1;

// Setting control enable by writing 1 to ctrl register
ctrl = (int*)(TIMER_BASE_ADDRESS + CTRL);
*ctrl = 1;
 int x=0,y=1,z=2,*e=0;
  e = (int*)(TIMER_BASE_ADDRESS+INTR);
 
  while(*e==0){ 
    x=y+z;
    y++;
  }

}


// int main(){

//    float a = 4.2,b=4.0,c = 1.0, d;
//    if(a > b)
//    c = c+1;
//    else 
//    c = 0;

//    if (c==2.0)
//    digitalWrite(1,1);


  // int a=1,b=2,c=300,d=0,*e,f=10;

// while (f<1){

//   digitalWrite(1);
//   delay(1000);
//   d=0;

 
//   d = *e;
//    while (d != 1){// for(int i=0; i<100; i++){
//     c = a+b;
//     a++;
//     b++;
//     d = *e;
//   }

// delay(1001);
// digitalWrite(0);
//   d = 0;
//    while (d != 1){// for(int i=0; i<100; i++){
//     c = a+b;
//     a++;
//     b++;
//     d = *e;
//   }

// }
// int i=0,j=0;
// GPIO TIMER AND PWM with interrupt
// while (f!=0){
// if(i<100)
// i=i+20;
// else 
// i=0;
// digitalWrite(0);
// delay(200);
// digitalWrite(1);
// delay(200);
// digitalWrite(3);
// delay(200);
// digitalWrite(0);
// delay(200);
// digitalWrite(2);
// delay(200);
// pwm(i,100);
// digitalWrite(3);
// delay(200);
// }

// GPIO with interrupts







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

































 void delayi(int z){
    int a=0,b=2,c=4;
    for(int i=0;i<15*z;i=i+2){
    a=b+c;
  }
 }