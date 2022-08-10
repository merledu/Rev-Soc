#define UART_BASE           0x2000A000
#define ADDR_BAUD           0x0
#define ADDR_TX_DATA        0x4
#define ADDR_RX_DATA        0x8
#define ADDR_RX_EN          0xc
#define ADDR_TX_FIFO_CLR    0x10
#define ADDR_RX_FIFO_CLR    0x14
#define ADDR_TX_FIFO_LEVEL  0x18
#define ADDR_RD_EN_TXFIFO   0x1c

// void uartTx(int baud, int clkfreq, char *str);