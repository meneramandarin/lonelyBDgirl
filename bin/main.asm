;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Mac OS X ppc)
;--------------------------------------------------------
	.module main
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _update_game
	.globl _update_title
	.globl _init_game
	.globl _init_title
	.globl _update_dialog
	.globl _show_dialog
	.globl _update_world
	.globl _init_world
	.globl _update_player
	.globl _init_player
	.globl _puts
	.globl _printf
	.globl _wait_vbl_done
	.globl _joypad
	.globl _gamestate
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
_gamestate::
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
;src/main.c:10: void init_title() {
;	---------------------------------
; Function init_title
; ---------------------------------
_init_title::
;src/main.c:11: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/main.c:12: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src/main.c:13: printf("lonely BD girl\n\nPress Start!");
	ld	de, #___str_0
	push	de
	call	_printf
	pop	hl
;src/main.c:14: }
	ret
___str_0:
	.ascii "lonely BD girl"
	.db 0x0a
	.db 0x0a
	.ascii "Press Start!"
	.db 0x00
;src/main.c:16: void init_game() {
;	---------------------------------
; Function init_game
; ---------------------------------
_init_game::
;src/main.c:18: printf("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
	ld	de, #___str_2
	call	_puts
;src/main.c:19: init_world();
	call	_init_world
;src/main.c:20: init_player();
	call	_init_player
;src/main.c:21: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;src/main.c:22: show_dialog();
;src/main.c:23: }
	jp	_show_dialog
___str_2:
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
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x00
;src/main.c:25: void update_title(void) {
;	---------------------------------
; Function update_title
; ---------------------------------
_update_title::
;src/main.c:26: if(joypad() & J_START) {
	call	_joypad
	rlca
	ret	NC
;src/main.c:27: gamestate = STATE_GAME;
	ld	hl, #_gamestate
	ld	(hl), #0x01
;src/main.c:28: init_game();
;src/main.c:30: }
	jp	_init_game
;src/main.c:32: void update_game(void) {
;	---------------------------------
; Function update_game
; ---------------------------------
_update_game::
;src/main.c:33: update_world();
	call	_update_world
;src/main.c:34: update_player();
	call	_update_player
;src/main.c:35: update_dialog();
;src/main.c:36: }
	jp	_update_dialog
;src/main.c:38: void main(void) {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;src/main.c:39: init_title();
	call	_init_title
;src/main.c:41: while(1) {
00105$:
;src/main.c:42: switch(gamestate) {
	ld	a, (#_gamestate)
	or	a, a
	jr	Z, 00101$
	ld	a, (#_gamestate)
	dec	a
	jr	Z, 00102$
	jr	00103$
;src/main.c:43: case STATE_TITLE:
00101$:
;src/main.c:44: update_title();
	call	_update_title
;src/main.c:45: break;
	jr	00103$
;src/main.c:46: case STATE_GAME:
00102$:
;src/main.c:47: update_game();
	call	_update_game
;src/main.c:49: }
00103$:
;src/main.c:50: wait_vbl_done();
	call	_wait_vbl_done
;src/main.c:52: }
	jr	00105$
	.area _CODE
	.area _INITIALIZER
__xinit__gamestate:
	.db #0x00	; 0
	.area _CABS (ABS)
