#include "uart.h"

void kernel_main()
{
    uart_init(9600);
    uart_puts("Hello, World!");

    while (1) {
    }
}
