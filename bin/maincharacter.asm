;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.1 #14650 (Mac OS X ppc)
;--------------------------------------------------------
	.module maincharacter
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _maincharacter_map
	.globl _maincharacter_tiles
	.globl _maincharacter_palettes
	.globl b___func_maincharacter
	.globl ___func_maincharacter
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
;src/game_states/maincharacter.c:7: BANKREF(maincharacter)
;	---------------------------------
; Function __func_maincharacter
; ---------------------------------
	b___func_maincharacter	= 0
___func_maincharacter::
	.local b___func_maincharacter 
	___bank_maincharacter = b___func_maincharacter 
	.globl ___bank_maincharacter 
	.area _CODE
_maincharacter_palettes:
	.dw #0x7fff
	.dw #0x5ad6
	.dw #0x294a
	.dw #0x0000
_maincharacter_tiles:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x0f	; 15
	.db #0x0d	; 13
	.db #0x1a	; 26
	.db #0x10	; 16
	.db #0x1d	; 29
	.db #0x15	; 21
	.db #0x1a	; 26
	.db #0x10	; 16
	.db #0x1f	; 31
	.db #0x13	; 19
	.db #0x1e	; 30
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0xf0	; 240
	.db #0x10	; 16
	.db #0xf8	; 248
	.db #0x08	; 8
	.db #0xf8	; 248
	.db #0x28	; 40
	.db #0x98	; 152
	.db #0x88	; 136
	.db #0x18	; 24
	.db #0x48	; 72	'H'
	.db #0x58	; 88	'X'
	.db #0x16	; 22
	.db #0x1a	; 26
	.db #0x14	; 20
	.db #0x38	; 56	'8'
	.db #0x27	; 39
	.db #0x20	; 32
	.db #0x21	; 33
	.db #0x26	; 38
	.db #0x1b	; 27
	.db #0x3c	; 60
	.db #0x08	; 8
	.db #0x0f	; 15
	.db #0x1f	; 31
	.db #0x09	; 9
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x48	; 72	'H'
	.db #0x58	; 88	'X'
	.db #0x28	; 40
	.db #0x1c	; 28
	.db #0xe4	; 228
	.db #0x04	; 4
	.db #0x84	; 132
	.db #0x64	; 100	'd'
	.db #0xd8	; 216
	.db #0x3c	; 60
	.db #0x10	; 16
	.db #0xf0	; 240
	.db #0xf8	; 248
	.db #0x90	; 144
	.db #0x00	; 0
	.db #0x00	; 0
_maincharacter_map:
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x03	; 3
	.area _INITIALIZER
	.area _CABS (ABS)
