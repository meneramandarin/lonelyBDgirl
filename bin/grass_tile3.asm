;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Mac OS X ppc)
;--------------------------------------------------------
	.module grass_tile3
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _grass_tile3_map
	.globl _grass_tile3_tiles
	.globl _grass_tile3_palettes
	.globl b___func_grass_tile3
	.globl ___func_grass_tile3
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
;src/maps/grass_tile3.c:7: BANKREF(grass_tile3)
;	---------------------------------
; Function __func_grass_tile3
; ---------------------------------
	b___func_grass_tile3	= 0
___func_grass_tile3::
	.local b___func_grass_tile3 
	___bank_grass_tile3 = b___func_grass_tile3 
	.globl ___bank_grass_tile3 
	.area _CODE
_grass_tile3_palettes:
	.dw #0x5ad6
	.dw #0x7fff
	.dw #0x0000
	.dw #0x0000
_grass_tile3_tiles:
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xaf	; 175
	.db #0x00	; 0
	.db #0xdf	; 223
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xbf	; 191
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0xec	; 236
	.db #0x00	; 0
	.db #0xe5	; 229
	.db #0x00	; 0
	.db #0xf7	; 247
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xbf	; 191
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xfd	; 253
	.db #0x00	; 0
	.db #0xd9	; 217
	.db #0x00	; 0
	.db #0xcb	; 203
	.db #0x00	; 0
	.db #0xef	; 239
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xf5	; 245
	.db #0x00	; 0
	.db #0xfb	; 251
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x5f	; 95
	.db #0x00	; 0
_grass_tile3_map:
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x03	; 3
	.area _INITIALIZER
	.area _CABS (ABS)
