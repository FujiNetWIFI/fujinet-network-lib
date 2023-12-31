        .export     _network_write

        .import     _bus
        .import     _io_status
        .import     _fn_device_error
        .import     _network_unit
        .import     copy_nw_cmd_data
        .import     popax

        .include    "device.inc"
        .include    "zp.inc"
        .include    "macros.inc"

; uint8_t network_write(char* devicespec, uint8_t *buf, uint16_t len)
_network_write:
        axinto  tmp7                    ; len

        ldy     #$00
        sty     _fn_device_error

        setax   #t_network_write

        jsr     copy_nw_cmd_data

        jsr     popax                   ; buf
        sta     IO_DCB::dbuflo
        stx     IO_DCB::dbufhi

        jsr     popax                   ; devicespec
        jsr     _network_unit           ; would be nice to skip this within the library if it's already done

        sta     IO_DCB::dunit
        sta     tmp6                    ; save unit
        setax   tmp7                    ; length into A/X, store it into IO_DCB
        sta     IO_DCB::dbytlo
        stx     IO_DCB::dbythi
        sta     IO_DCB::daux1
        stx     IO_DCB::daux2

        jsr     _bus

        lda     tmp6                    ; restore the unit
        jmp     _io_status

t_network_write:
        .byte 'W', $80, $ff, $ff, $ff, $ff
