        .export         _fn_io_enable_udpstream

        .import         copy_io_cmd_data
        .import         _bus
        .import         popa, popax

        .include        "zp.inc"
        .include        "macros.inc"
        .include        "device.inc"

; void fn_io_enable_udpstream(uint16_t port, char *host);
;
.proc _fn_io_enable_udpstream
        axinto  tmp7                    ; host
        setax   #t_fn_io_enable_udpstream
        jsr     copy_io_cmd_data

        mwa     tmp7, IO_DCB::dbuflo
        jsr     popax                   ; port
        sta     IO_DCB::daux1
        stx     IO_DCB::daux2

        jmp     _bus
.endproc

.rodata
t_fn_io_enable_udpstream:
        .byte $f0, $80, 64, 0, $ff, $ff
