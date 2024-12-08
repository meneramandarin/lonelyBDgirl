#ifndef METASPRITE_grass_tile1_H
#define METASPRITE_grass_tile1_H

#include <stdint.h>
#include <gbdk/platform.h>
#include <gbdk/metasprites.h>

#define grass_tile1_TILE_ORIGIN 0
#define grass_tile1_TILE_W 8
#define grass_tile1_TILE_H 8
#define grass_tile1_WIDTH 16
#define grass_tile1_HEIGHT 16
#define grass_tile1_TILE_COUNT 4
#define grass_tile1_PALETTE_COUNT 1
#define grass_tile1_COLORS_PER_PALETTE 4
#define grass_tile1_TOTAL_COLORS 4
#define grass_tile1_MAP_ATTRIBUTES 0
extern const unsigned char grass_tile1_map[4];
#define grass_tile1_map_attributes grass_tile1_map

BANKREF_EXTERN(grass_tile1)

extern const palette_color_t grass_tile1_palettes[4];
extern const uint8_t grass_tile1_tiles[64];

#endif