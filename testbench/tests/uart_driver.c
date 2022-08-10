/**
@file uart.c
@brief Contains the driver routines for UART interface.
@detail The UART driver .has software functions to configure, transmit 
and receive over UART interface.
*/

#include "uart_header.h"
#include <math.h>
#include <stdint.h>

void uart_init(unsigned int baud_rate , unsigned int clock_frequency){
	//computing formula : baud_rate = clock_frequency/baud_rate
	uint32_t clock_per_bit = (clock_frequency / baud_rate) + 1;
	mem_write32(UART_BASE, ADDR_RD_EN_TXFIFO , ((clock_per_bit << 3 | 2)));
}

void uart_send_char(char val ){
	//transmitting character 
	mem_write32(UART_BASE, ADDR_TX_DATA, 	val);
	//uint32_t nco = mem_read32(UART_BASE_ADDRESS, UART_CNTRL_REGISTER_OFFSET);
	//uint32_t a = nco >> 3;
	//mem_write32(UART_BASE_ADDRESS, UART_CNTRL_REGISTER_OFFSET, a | 1); 
}

void mem_write32(uint32_t base, uint32_t offset,
                                uint32_t value) {
  ((volatile uint32_t *)base)[offset / sizeof(uint32_t)] = value;
}


void uart_send_str(char *str){
	//transmitting string
	while(*str != '\0'){
		uart_send_char(*str++);
	}
}

int uart_polled_data(){
	//polling uart
	uint32_t rcv_status = mem_read32(UART_BASE_ADDRESS, UART_CNTRL_REGISTER_OFFSET);
	uint32_t rcv = rcv_status >> 2;
	rcv = rcv_status << 31;
	rcv = rcv_status >> 31;

	if(rcv == 1){
		uint32_t ret;
		return ret = mem_read32(UART_BASE_ADDRESS, UART_RDATA_REGISTER_OFFSET);
	}
	else{
		return -1;
	}
}

