        .export     _main

        .import     _sp_find_clock
        .import     _sp_init

        .include    "macros.inc"

.proc _main
        jsr     _sp_init
        jmp     _sp_find_clock
.endproc
