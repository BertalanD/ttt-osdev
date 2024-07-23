#include "fb.h"

void kernel_main()
{
    fb_init();
    drawChar('H', 0, 0, 0x0F);
    drawChar('e', 1, 0, 0x0F);

    while (1) {
    }
}
