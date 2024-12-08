;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Mac OS X ppc)
;--------------------------------------------------------
	.module dialog
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _printf
	.globl _joypad
	.globl _dialog_state
	.globl _show_dialog
	.globl _update_dialog
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_dialog_state::
	.ds 1
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;src/dialog/dialog.c:7: void show_dialog(void) {
;	---------------------------------
; Function show_dialog
; ---------------------------------
_show_dialog::
;src/dialog/dialog.c:8: switch(dialog_state) {
	ld	a, (#_dialog_state)
	or	a, a
	jr	Z, 00101$
	ld	a, (#_dialog_state)
	dec	a
	jr	Z, 00102$
	ret
;src/dialog/dialog.c:9: case 0:
00101$:
;src/dialog/dialog.c:10: printf("\n\n\n\n\n\n\n\n\n\n\nCongratulations!\nYou got hired for a\nBD role!");
	ld	de, #___str_0
	push	de
	call	_printf
	pop	hl
;src/dialog/dialog.c:11: break;
	ret
;src/dialog/dialog.c:12: case 1:
00102$:
;src/dialog/dialog.c:13: printf("\n\n\n\n\n\n\n\n\n\n\nGet ready for your\nfirst conference!");
	ld	de, #___str_1
	push	de
	call	_printf
	pop	hl
;src/dialog/dialog.c:15: }
;src/dialog/dialog.c:16: }
	ret
___str_0:
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.ascii "Congratulations!"
	.db 0x0a
	.ascii "You got hired for a"
	.db 0x0a
	.ascii "BD role!"
	.db 0x00
___str_1:
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.ascii "Get ready for your"
	.db 0x0a
	.ascii "first conference!"
	.db 0x00
;src/dialog/dialog.c:18: void update_dialog(void) {
;	---------------------------------
; Function update_dialog
; ---------------------------------
_update_dialog::
;src/dialog/dialog.c:19: if(joypad() & J_A) {
	call	_joypad
	bit	4, a
	ret	Z
;src/dialog/dialog.c:20: dialog_state++;
	ld	hl, #_dialog_state
	inc	(hl)
;src/dialog/dialog.c:21: if(dialog_state <= 1) {
	ld	a, #0x01
	sub	a, (hl)
;src/dialog/dialog.c:22: show_dialog();
	jp	NC,_show_dialog
;src/dialog/dialog.c:25: }
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__dialog_state:
	.db #0x00	; 0
	.area _CABS (ABS)
