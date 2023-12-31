        .export         _fn_io_get_scan_result
        .import         copy_io_cmd_data, _bus
        .import         popa

        .include        "zp.inc"
        .include        "macros.inc"
        .include        "fujinet-io.inc"
        .include        "device.inc"

; void fn_io_get_scan_result(uint8_t network_index, SSIDInfo *ssid_info)
;
; caller must supply memory location for ssidinfo to go
.proc _fn_io_get_scan_result
        axinto  tmp7            ; location to put ssidinfo into

        setax   #t_io_get_scan_result
        jsr     copy_io_cmd_data

        jsr     popa            ; network index
        sta     IO_DCB::daux1
        mwa     tmp7, IO_DCB::dbuflo
        jmp     _bus
.endproc

.rodata
.define SIsz .sizeof(SSIDInfo)

t_io_get_scan_result:
        .byte $fc, $40, <SIsz, >SIsz, $ff, $00
