#ifndef PLAYER_H
#define PLAYER_H

#include <gb/gb.h>
#include <stdint.h>

// Player state
extern UINT8 player_x;
extern UINT8 player_y;

// Player functions
void init_player(void);
void update_player(void);
void move_player(void);

#endif

