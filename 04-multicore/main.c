#include "fb.h"

void(* volatile cpu1_job)() = 0;

void cpu1_main()
{
    drawChar('l', 3, 0, 0x0F);
    drawChar('l', 4, 0, 0x0F);
}

void run_on_cpu1(void(*func)())
{
    cpu1_job = func;
    __asm__ volatile("sev");
}

void kernel_main()
{
    fb_init();
    drawChar('H', 0, 0, 0x0F);
    drawChar('e', 1, 0, 0x0F);

    run_on_cpu1(cpu1_main);

    while (1) {
    }
}
