ENTRY(_start)

/* Erre a címre ugrik a CPU a bekapcsolás után */
LOAD_ADDR = 0x80000;

SECTIONS
{
    . = LOAD_ADDR;
    .text : { KEEP(*(.text.boot)) *(.text .text.*) }
    .rodata : { *(.rodata .rodata.*) }
    .data : { *(.data .data.*) }
    .bss (NOLOAD) : {
        . = ALIGN(16);
        __bss_start = .;
        *(.bss .bss.*)
        *(COMMON)
        __bss_end = .;
    }

    .cpu1Stack :
    {
        . = ALIGN(16);
        __stack_start  = .;
        . = . + 4096;
        __cpu1_stack  = .;
    }


   /DISCARD/ : { *(.comment) *(.gnu*) *(.note*) *(.eh_frame*) }
}
