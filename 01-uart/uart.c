#include "uart.h"

// https://datasheets.raspberrypi.com/bcm2711/bcm2711-peripherals.pdf

struct registers {
	unsigned DR;
	unsigned RSRECR;
	unsigned unused[4];
	unsigned FR;
	unsigned ILPR;
	unsigned IBRD;
	unsigned FBRD;
	unsigned LCRH;
	unsigned CR;
	unsigned IFLS;
	unsigned IMSC;
	unsigned RIS;
	unsigned MIS;
	unsigned ICR;
	unsigned DMACR;
};

// XXX: GPU mapping
#define BASE_ADDR 0xfe201000
#define REGS (*(struct registers volatile*)BASE_ADDR)

void uart_init(int baud)
{
    // TODO
}

#define TXFF (1 << 5)

static bool ready_to_send()
{
    return !(REGS.FR & TXFF);
}

void uart_putc(char ch)
{
    while (!ready_to_send());

    REGS.DR = ch;
}

void uart_puts(char const* str)
{
    while (str)
        uart_putc(*str++);
}
