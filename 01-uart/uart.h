#pragma once

void uart_init(int baud);
void uart_putc(char ch);
void uart_puts(char const* str);
