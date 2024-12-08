#include "../../include/player.h"
#include "../../include/maincharacter.h"
#include <gb/gb.h>
#include <stdio.h> 

// Player position
UINT8 player_x = 84;
UINT8 player_y = 84;
#define MOVEMENT_SPEED 2

void init_player(void) {
    // Load player sprites
    set_sprite_data(0, maincharacter_TILE_COUNT, maincharacter_tiles);
    set_sprite_tile(0, 0);
    set_sprite_tile(1, 1);
    set_sprite_tile(2, 2);
    set_sprite_tile(3, 3);
    
    // Set initial position
    move_sprite(0, player_x, player_y);
    move_sprite(1, player_x + 8, player_y);
    move_sprite(2, player_x, player_y + 8);
    move_sprite(3, player_x + 8, player_y + 8);
}

void update_player(void) {
    
    UINT8 keys = joypad();
    
      if(keys & J_LEFT) {
        player_x -= MOVEMENT_SPEED;
        if(player_x < 8) player_x = 8;
    }
    if(keys & J_RIGHT) {
        player_x += MOVEMENT_SPEED;
        if(player_x > 160) player_x = 160;
    }
    if(keys & J_UP) {
        player_y -= MOVEMENT_SPEED;
        if(player_y < 16) player_y = 16;
    }
    if(keys & J_DOWN) {
        player_y += MOVEMENT_SPEED;
        if(player_y > 152) player_y = 152;
    }

    // Update sprite positions
    move_sprite(0, player_x, player_y);
    move_sprite(1, player_x + 8, player_y);
    move_sprite(2, player_x, player_y + 8);
    move_sprite(3, player_x + 8, player_y + 8);
}