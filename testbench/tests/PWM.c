#include "pwm.h"
#include <stdbool.h>
#include <stdint.h>


void pwm(int dutyCycle,int Period)
{

int *dutycyc, *period, *ctrl, *divisor; // Pointer declaration
// Disabling PWM by writing zero to the control register
ctrl = (int*)(PWM_BASE + ctrl_1);
*ctrl = 0;
// Setting Divisor to 2
divisor = (int*)(PWM_BASE + divisor_1);
*divisor = 0x1;

// Setting Period to input argument
period = (int*)(PWM_BASE + period_1);
*period = Period;

// Setting Duty cycle to input argument
dutycyc = (int*)(PWM_BASE + DC_1);
*dutycyc = dutyCycle;


// Setting control enable by writing 0x7 to ctrl register
ctrl = (int*)(PWM_BASE + ctrl_1);
*ctrl = 0x7;

}

int main(){
  int a=1,b=2,c=300;
  pwm(10,100);
  for(int i=0; i<100; i++){
    c = a+b;
    a++;
    b++;
  }
  pwm(30,100);
  for(int i=0; i<100; i++){
  c = a+b;
  a++;
  b++;
  }
  pwm(60,100);
  for(int i=0; i<100; i++){
  c = a+b;
  a++;
  b++;
  }
  pwm(80,100);
  for(int i=0; i<100; i++){
  c = a+b;
  a++;
  b++;
  }
    pwm(100,100);
  for(int i=0; i<100; i++){
  c = a+b;
  a++;
  b++;
  }

  return 0;
}
