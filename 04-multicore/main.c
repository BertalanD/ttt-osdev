#include "fb.h"

void(* volatile cpu1_job)() = 0;

void cpu1_main()
{
}

void run_on_cpu1(void(*func)())
{
    cpu1_job = func;
    __asm__ volatile("sev");
}

void kernel_main()
{
    fb_init();

    run_on_cpu1(cpu1_main);

    while (1) {
    }
}
