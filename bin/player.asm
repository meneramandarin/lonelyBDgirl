;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Mac OS X ppc)
;--------------------------------------------------------
	.module player
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _set_sprite_data
	.globl _joypad
	.globl _player_y
	.globl _player_x
	.globl _init_player
	.globl _update_player
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
_player_x::
	.ds 1
_player_y::
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
;src/game_states/player.c:11: void init_player(void) {
;	---------------------------------
; Function init_player
; ---------------------------------
_init_player::
;src/game_states/player.c:13: set_sprite_data(0, maincharacter_TILE_COUNT, maincharacter_tiles);
	ld	de, #_maincharacter_tiles
	push	de
	ld	hl, #0x400
	push	hl
	call	_set_sprite_data
	add	sp, #4
;/Users/marleneronstedt/dev/gbdev/gbdk/include/gb/gb.h:1875: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x00
	ld	hl, #(_shadow_OAM + 6)
	ld	(hl), #0x01
	ld	hl, #(_shadow_OAM + 10)
	ld	(hl), #0x02
	ld	hl, #(_shadow_OAM + 14)
	ld	(hl), #0x03
;src/game_states/player.c:20: move_sprite(0, player_x, player_y);
	ld	hl, #_player_y
	ld	b, (hl)
	ld	hl, #_player_x
	ld	c, (hl)
;/Users/marleneronstedt/dev/gbdev/gbdk/include/gb/gb.h:1961: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;/Users/marleneronstedt/dev/gbdev/gbdk/include/gb/gb.h:1962: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;src/game_states/player.c:21: move_sprite(1, player_x + 8, player_y);
	ld	hl, #_player_y
	ld	b, (hl)
	ld	a, (#_player_x)
	add	a, #0x08
	ld	c, a
;/Users/marleneronstedt/dev/gbdev/gbdk/include/gb/gb.h:1961: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 4)
;/Users/marleneronstedt/dev/gbdev/gbdk/include/gb/gb.h:1962: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;src/game_states/player.c:22: move_sprite(2, player_x, player_y + 8);
	ld	a, (#_player_y)
	add	a, #0x08
	ld	b, a
	ld	hl, #_player_x
	ld	c, (hl)
;/Users/marleneronstedt/dev/gbdev/gbdk/include/gb/gb.h:1961: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 8)
;/Users/marleneronstedt/dev/gbdev/gbdk/include/gb/gb.h:1962: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;src/game_states/player.c:23: move_sprite(3, player_x + 8, player_y + 8);
	ld	a, (#_player_y)
	add	a, #0x08
	ld	b, a
	ld	a, (#_player_x)
	add	a, #0x08
	ld	c, a
;/Users/marleneronstedt/dev/gbdev/gbdk/include/gb/gb.h:1961: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 12)
;/Users/marleneronstedt/dev/gbdev/gbdk/include/gb/gb.h:1962: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;src/game_states/player.c:23: move_sprite(3, player_x + 8, player_y + 8);
;src/game_states/player.c:24: }
	ret
;src/game_states/player.c:26: void update_player(void) {
;	---------------------------------
; Function update_player
; ---------------------------------
_update_player::
;src/game_states/player.c:28: UINT8 keys = joypad();
	call	_joypad
	ld	c, a
;src/game_states/player.c:30: if(keys & J_LEFT) {
	bit	1, c
	jr	Z, 00104$
;src/game_states/player.c:31: player_x -= MOVEMENT_SPEED;
	ld	hl, #_player_x
	ld	a, (hl)
	add	a, #0xfe
	ld	(hl), a
;src/game_states/player.c:32: if(player_x < 8) player_x = 8;
	ld	a, (hl)
	sub	a, #0x08
	jr	NC, 00104$
	ld	(hl), #0x08
00104$:
;src/game_states/player.c:34: if(keys & J_RIGHT) {
	bit	0, c
	jr	Z, 00108$
;src/game_states/player.c:35: player_x += MOVEMENT_SPEED;
	ld	hl, #_player_x
	ld	a, (hl)
	add	a, #0x02
	ld	(hl), a
;src/game_states/player.c:36: if(player_x > 160) player_x = 160;
	ld	a, #0xa0
	sub	a, (hl)
	jr	NC, 00108$
	ld	(hl), #0xa0
00108$:
;src/game_states/player.c:38: if(keys & J_UP) {
	bit	2, c
	jr	Z, 00112$
;src/game_states/player.c:39: player_y -= MOVEMENT_SPEED;
	ld	hl, #_player_y
	ld	a, (hl)
	add	a, #0xfe
	ld	(hl), a
;src/game_states/player.c:40: if(player_y < 16) player_y = 16;
	ld	a, (hl)
	sub	a, #0x10
	jr	NC, 00112$
	ld	(hl), #0x10
00112$:
;src/game_states/player.c:42: if(keys & J_DOWN) {
	bit	3, c
	jr	Z, 00116$
;src/game_states/player.c:43: player_y += MOVEMENT_SPEED;
	ld	hl, #_player_y
	ld	a, (hl)
	add	a, #0x02
	ld	(hl), a
;src/game_states/player.c:44: if(player_y > 152) player_y = 152;
	ld	a, #0x98
	sub	a, (hl)
	jr	NC, 00116$
	ld	(hl), #0x98
00116$:
;src/game_states/player.c:48: move_sprite(0, player_x, player_y);
	ld	hl, #_player_y
	ld	b, (hl)
	ld	hl, #_player_x
	ld	c, (hl)
;/Users/marleneronstedt/dev/gbdev/gbdk/include/gb/gb.h:1961: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;/Users/marleneronstedt/dev/gbdev/gbdk/include/gb/gb.h:1962: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;src/game_states/player.c:49: move_sprite(1, player_x + 8, player_y);
	ld	hl, #_player_y
	ld	b, (hl)
	ld	a, (#_player_x)
	add	a, #0x08
	ld	c, a
;/Users/marleneronstedt/dev/gbdev/gbdk/include/gb/gb.h:1961: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 4)
;/Users/marleneronstedt/dev/gbdev/gbdk/include/gb/gb.h:1962: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;src/game_states/player.c:50: move_sprite(2, player_x, player_y + 8);
	ld	a, (#_player_y)
	add	a, #0x08
	ld	b, a
	ld	hl, #_player_x
	ld	c, (hl)
;/Users/marleneronstedt/dev/gbdev/gbdk/include/gb/gb.h:1961: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 8)
;/Users/marleneronstedt/dev/gbdev/gbdk/include/gb/gb.h:1962: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;src/game_states/player.c:51: move_sprite(3, player_x + 8, player_y + 8);
	ld	a, (#_player_y)
	add	a, #0x08
	ld	b, a
	ld	a, (#_player_x)
	add	a, #0x08
	ld	c, a
;/Users/marleneronstedt/dev/gbdev/gbdk/include/gb/gb.h:1961: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 12)
;/Users/marleneronstedt/dev/gbdev/gbdk/include/gb/gb.h:1962: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;src/game_states/player.c:51: move_sprite(3, player_x + 8, player_y + 8);
;src/game_states/player.c:52: }
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__player_x:
	.db #0x54	; 84	'T'
__xinit__player_y:
	.db #0x54	; 84	'T'
	.area _CABS (ABS)
