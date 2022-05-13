#include "uart_header.h"
#include <stdbool.h>
#include <stdint.h>

void uartTx(int baud, int clkfreq, int byte1,int byte2,int byte3,int byte4)
{
int clk_per_bit,bit_per_clk=1,clk_clk=3;
int *baud_reg, *ctrl_reg, *tx_level, *data_reg, *data_reg2, *data_reg3, *data_reg4, *tx_en, *rx_en; // Pointer declaration
// Disabling timer by writing zero to the control register

clk_per_bit = clkfreq/baud;
ctrl_reg = (int*)(UART_BASE + ADDR_RD_EN_TXFIFO);
*ctrl_reg = 0;

// Setting prescale to zero and step to 1
baud_reg = (int*)(UART_BASE + ADDR_BAUD);
*baud_reg = clk_per_bit;

// Setting timer lower reg to the given delay
tx_level = (int*)(UART_BASE + ADDR_TX_FIFO_LEVEL);
*tx_level = 0x3;

// Setting timer Upper reg to zero
data_reg = (int*)(UART_BASE + ADDR_TX_DATA);
*data_reg = byte1;
bit_per_clk = clk_per_bit;
data_reg2 = (int*)(UART_BASE + ADDR_TX_DATA);
*data_reg2 = byte2;
bit_per_clk = clk_clk+clk_per_bit;
data_reg3 = (int*)(UART_BASE + ADDR_TX_DATA);
*data_reg3 = byte3;
bit_per_clk = clk_clk+clk_per_bit+bit_per_clk;
data_reg4 = (int*)(UART_BASE + ADDR_TX_DATA);
*data_reg4 = byte4;

// Setting interrupt enable by writing 1
tx_en = (int*)(UART_BASE + ADDR_RD_EN_TXFIFO);
*tx_en = 1;

rx_en = (int*)(UART_BASE + ADDR_RX_EN);
*rx_en = 1;

}

int main(){
  int a=1,b=2,c=300;
  uartTx(115200,100000000,4,8,16,150);
  for(int i=0; i<1000; i++){
    c = a+b;
    a++;
    b++;
  }
  return 0;
}
