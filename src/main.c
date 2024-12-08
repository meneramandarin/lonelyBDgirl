#include <gb/gb.h>
#include <stdio.h>
#include "../include/game_states.h"
#include "../include/player.h"
#include "../include/world.h"
#include "../include/dialog.h"

UINT8 gamestate = STATE_TITLE;

void init_title() {
    SHOW_BKG;
    DISPLAY_ON;
    printf("lonely BD girl\n\nPress Start!");
}

void init_game() {
    // Clear the previous screen
    printf("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
    init_world();
    init_player();
    SHOW_SPRITES;
    show_dialog();
}

void update_title(void) {
    if(joypad() & J_START) {
        gamestate = STATE_GAME;
        init_game();
    }
}

void update_game(void) {
    update_world();
    update_player();
    update_dialog();
}

void main(void) {
    init_title();
    
    while(1) {
        switch(gamestate) {
            case STATE_TITLE:
                update_title();
                break;
            case STATE_GAME:
                update_game();
                break;
        }
        wait_vbl_done();
    }
}