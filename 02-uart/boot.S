.section ".text.start"

// Mind a 4 processzormagon ez a belépési pont.
// Az első argumentumban (x0) a Device Tree physmem pointere található.
.global _start
.type _start, @function
_start:
    // Csak a 0-s magon szeretnénk az inicializáló kódot lefuttatni,
    // MPIDR[0:7] tartalmazza mag azonosítóját. Ha nem a 0-s, busy loopba ugrunk.
    mrs x1, MPIDR_EL1
    and x1, x1, #15
    cbnz x1, halt

    // Mivel _start garantáltan a legelső függvény a .text szegmensben, az előtte
    // lévő memóriaterületet felhasználhatjuk a stack-nek (lefelé nő!).
    adrp x14, _start
    add x14, x14, :lo12:_start
    mov sp, x14

    // BSS kitöltése 0 bájtokkal.
    adrp x14, __bss_start
    add x14, x14, :lo12:__bss_start
    ldr x15, __bss_end
    add x15, x15, :lo12:__bss_end
.Lloop:
    str xzr, [x14]
    add x14, x14, #8
    cmp x14, x15
    b.lo .Lloop

    // Ugrás a kernel C-ben írt részeire.
    b kernel_main

halt:
    wfe
    b halt

