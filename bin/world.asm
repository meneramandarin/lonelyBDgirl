;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Mac OS X ppc)
;--------------------------------------------------------
	.module world
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _set_bkg_palette
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _grass_timer
	.globl _init_world
	.globl _update_world
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_update_world_current_grass_20001_174:
	.ds 1
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_grass_timer::
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
;src/maps/world.c:26: static uint8_t current_grass = 0;
	ld	hl, #_update_world_current_grass_20001_174
	ld	(hl), #0x00
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;src/maps/world.c:8: void init_world(void) {
;	---------------------------------
; Function init_world
; ---------------------------------
_init_world::
	dec	sp
;src/maps/world.c:10: set_bkg_palette(0, 1, grass_tile1_palettes);
	ld	de, #_grass_tile1_palettes
	push	de
	xor	a, a
	inc	a
	push	af
	call	_set_bkg_palette
	add	sp, #4
;src/maps/world.c:11: set_bkg_data(0, grass_tile2_TILE_COUNT, grass_tile1_tiles);
	ld	de, #_grass_tile1_tiles
	push	de
	ld	hl, #0x400
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/maps/world.c:14: unsigned char grass_map[] = {0};
	ldhl	sp,	#0
	ld	(hl), #0x00
;src/maps/world.c:15: for(uint8_t y = 0; y < 18; y++) {
	ld	c, #0x00
00107$:
	ld	a, c
	sub	a, #0x12
	jr	NC, 00109$
;src/maps/world.c:16: for(uint8_t x = 0; x < 20; x++) {
	ld	b, #0x00
00104$:
	ld	a, b
	sub	a, #0x14
	jr	NC, 00108$
;src/maps/world.c:17: set_bkg_tiles(x, y, 1, 1, grass_map);
	ld	hl, #0
	add	hl, sp
	push	hl
	ld	hl, #0x101
	push	hl
	ld	a, c
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_set_bkg_tiles
	add	sp, #6
;src/maps/world.c:16: for(uint8_t x = 0; x < 20; x++) {
	inc	b
	jr	00104$
00108$:
;src/maps/world.c:15: for(uint8_t y = 0; y < 18; y++) {
	inc	c
	jr	00107$
00109$:
;src/maps/world.c:20: }
	inc	sp
	ret
;src/maps/world.c:22: void update_world(void) {
;	---------------------------------
; Function update_world
; ---------------------------------
_update_world::
;src/maps/world.c:23: grass_timer++;
	ld	hl, #_grass_timer
	inc	(hl)
;src/maps/world.c:24: if(grass_timer > 60) {
	ld	a, #0x3c
	sub	a, (hl)
	ret	NC
;src/maps/world.c:25: grass_timer = 0;
	ld	(hl), #0x00
;src/maps/world.c:27: switch(current_grass) {
	ld	a, (#_update_world_current_grass_20001_174)
	or	a, a
	jr	Z, 00101$
	ld	a, (#_update_world_current_grass_20001_174)
	dec	a
	jr	Z, 00102$
	ld	a, (#_update_world_current_grass_20001_174)
	sub	a, #0x02
	jr	Z, 00103$
	jr	00104$
;src/maps/world.c:28: case 0:
00101$:
;src/maps/world.c:29: set_bkg_data(0, grass_tile2_TILE_COUNT, grass_tile2_tiles);
	ld	de, #_grass_tile2_tiles
	push	de
	ld	hl, #0x400
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/maps/world.c:30: break;
	jr	00104$
;src/maps/world.c:31: case 1:
00102$:
;src/maps/world.c:32: set_bkg_data(0, grass_tile3_TILE_COUNT, grass_tile3_tiles);
	ld	de, #_grass_tile3_tiles
	push	de
	ld	hl, #0x400
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/maps/world.c:33: break;
	jr	00104$
;src/maps/world.c:34: case 2:
00103$:
;src/maps/world.c:35: set_bkg_data(0, grass_tile1_TILE_COUNT, grass_tile1_tiles);
	ld	de, #_grass_tile1_tiles
	push	de
	ld	hl, #0x400
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/maps/world.c:37: }
00104$:
;src/maps/world.c:38: current_grass = (current_grass + 1) % 3;
	ld	hl, #_update_world_current_grass_20001_174
	ld	e, (hl)
	xor	a, a
	ld	d, a
	inc	de
	ld	bc, #0x0003
	call	__modsint
	ld	hl, #_update_world_current_grass_20001_174
	ld	(hl), c
;src/maps/world.c:40: }
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__grass_timer:
	.db #0x00	; 0
	.area _CABS (ABS)
