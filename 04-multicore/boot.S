.globl cpu1_job

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
    cbz x1, .Lcore0
    cmp x1, #1
    beq .Lcore1


.Lhalt:
    wfe
    b .Lhalt

.Lcore0:
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

    sev
    mov x1, 0xe0
	ldr x2, =_start
	str	x2, [x1]
	sev


    // Ugrás a kernel C-ben írt részeire.
    b kernel_main

.Lcore1:
    adrp x14, __cpu1_stack
    add x14, x14, :lo12:__cpu1_stack
    mov sp, x14

.Lwait:
    wfe
    adrp x14, cpu1_job
    ldr  x14, [x14, :lo12:cpu1_job]
    cmp x14, #0
    b.eq .Lwait
    br x14
    str xzr, [x14]
    b .Lwait

.ltorg

.org 0xd8
.globl spin_cpu0
spin_cpu0:
        .quad 0

.org 0xe0
.globl spin_cpu1
spin_cpu1:
        .quad 0

.org 0xe8
.globl spin_cpu2
spin_cpu2:
        .quad 0

.org 0xf0
.globl spin_cpu3
spin_cpu3:
        .quad 0