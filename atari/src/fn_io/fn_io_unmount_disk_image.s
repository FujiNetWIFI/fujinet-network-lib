        .export     _fn_io_unmount_disk_image
        .import     copy_io_cmd_data, _bus

        .include    "zp.inc"
        .include    "macros.inc"
        .include    "device.inc"

; void _fn_io_unmount_disk_image(uint8_t ds)
.proc _fn_io_unmount_disk_image
        sta     tmp8    ; save device slot

        setax   #t_io_unmount_disk_image
        jsr     copy_io_cmd_data

        mva     tmp8, IO_DCB::daux1
        jmp     _bus
.endproc

.rodata
t_io_unmount_disk_image:
        .byte $e9, $00, $00, $00, $ff, $00