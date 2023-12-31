        .export     _fn_io_set_boot_mode
        .import     copy_io_cmd_data, _bus

        .include    "zp.inc"
        .include    "macros.inc"
        .include    "device.inc"

; void _fn_io_set_boot_mode(uint8_t mode)
.proc _fn_io_set_boot_mode
        sta     tmp7    ; save mode

        setax   #t_io_set_boot_mode
        jsr     copy_io_cmd_data

        mva     tmp7, IO_DCB::daux1
        jmp     _bus
.endproc

.rodata
t_io_set_boot_mode:
        .byte $d6, $00, $00, $00, $ff, $00