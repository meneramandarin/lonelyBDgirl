#include "../../include/world.h"
#include "../../include/grass_tile1.h"
#include "../../include/grass_tile2.h"
#include "../../include/grass_tile3.h"

uint8_t grass_timer = 0;

void init_world(void) {
    // Initialize grass background
    set_bkg_palette(0, 1, grass_tile1_palettes);
    set_bkg_data(0, grass_tile2_TILE_COUNT, grass_tile1_tiles);
    
    // Fill screen
    unsigned char grass_map[] = {0};
    for(uint8_t y = 0; y < 18; y++) {
        for(uint8_t x = 0; x < 20; x++) {
            set_bkg_tiles(x, y, 1, 1, grass_map);
        }
    }
}

void update_world(void) {
    grass_timer++;
    if(grass_timer > 60) {
        grass_timer = 0;
        static uint8_t current_grass = 0;
        switch(current_grass) {
            case 0:
                set_bkg_data(0, grass_tile2_TILE_COUNT, grass_tile2_tiles);
                break;
            case 1:
                set_bkg_data(0, grass_tile3_TILE_COUNT, grass_tile3_tiles);
                break;
            case 2:
                set_bkg_data(0, grass_tile1_TILE_COUNT, grass_tile1_tiles);
                break;
        }
        current_grass = (current_grass + 1) % 3;
    }
}