        .export         _fn_io_get_host_slots
        .import         copy_io_cmd_data, _bus

        .include        "zp.inc"
        .include        "macros.inc"
        .include        "fujinet-io.inc"
        .include        "device.inc"

; void fn_io_get_host_slots(struct HostSlot *host_slots)
.proc _fn_io_get_host_slots
        axinto  tmp7
        setax   #t_io_get_host_slots
        jsr     copy_io_cmd_data

        mwa     tmp7, IO_DCB::dbuflo
        jmp     _bus
.endproc

.rodata
.define HS8zL .lobyte(.sizeof(HostSlot)*8)
.define HS8zH .hibyte(.sizeof(HostSlot)*8)

t_io_get_host_slots:
        .byte $f4, $40, HS8zL, HS8zH, $00, $00
