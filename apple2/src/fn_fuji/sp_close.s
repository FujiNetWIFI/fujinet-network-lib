        .export     _sp_close

        .import     _sp_cmdlist
        .import     _sp_error
        .import     _sp_dispatch
        .import     pusha

        .include    "sp.inc"
        .include    "macros.inc"

; int8_t sp_close(uint8_t dest)
;
; Close smartport device
; this changes _sp_payload
; returns any error code from _sp_dispatch call
.proc _sp_close
        sta     _sp_cmdlist+1          ; dest
        lda     #SP_CLOSE_PARAM_COUNT
        sta     _sp_cmdlist

        pusha   #SP_CMD_CLOSE
        setax   #_sp_cmdlist
        jsr     _sp_dispatch

        sta     _sp_error

        ldx     #$00
        lda     _sp_error
        rts
.endproc
