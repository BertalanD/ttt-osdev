#include "uart.h"

void kernel_main()
{
    uart_init(9600);
    uart_puts("Hello, World!\n");

    while (1) {
    }
}
