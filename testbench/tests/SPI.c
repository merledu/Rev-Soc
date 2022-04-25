#include "spi.h"
#include <stdbool.h>
#include <stdint.h>


int main(){
  int a=1,b=2,c=300;
  int *clk_div, *length, *cmd, *addr, *dummy, *data, *status; // Pointer declaration
  // Setting Clock Divider to zero
  clk_div = (int*)(SPI_BASE + CLK_DIV);
  *clk_div = 0;
  // Setting Length Register
  length = (int*)(SPI_BASE + LENGTH_REG);
  *length = 0x202008; // li t2,0x202008  // PWDATA  = {16'd32,2'd0,6'd32,2'd0,6'd8}; 
  // 32 bit data 32 bit address 8 bit command 
  
  // Setting Command to 1
  cmd = (int*)(SPI_BASE + CMD_REG);
  *cmd = 0x1;

  // Address to F or 15 in decimal
  addr = (int*)(SPI_BASE + ADDR_REG);
  *addr = 0xF;

  // Setting Dummy read and write to 8 each
  dummy = (int*)(SPI_BASE + DUMMY_CYC);
  *dummy = 0x80008;

  // Setting data to write in FIFO register  
  data = (int*)(SPI_BASE + DATA_REG);
  *data = 0xAAAAAAAA;
  // Enabling the standard mode data Transfer from SPI master
  status = (int*)(SPI_BASE + STATUS_REG);
  *status = 0x102;

  for(int i=0; i<100; i++){
    c = a+b;
    a++;
    b++;
  }
  return 0;
}
