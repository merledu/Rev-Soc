#define PWM_BASE  0x20008000
#define ctrl_1    0x0
#define	divisor_1 0x4
#define period_1	0x8
#define DC_1		  0xc

void pwm(int dutyCycle,int Period);