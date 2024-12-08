#!/bin/bash

# Ensure we're in the right directory
cd ~/dev/gbdev/lonely-bd-girl

# Compile all source files
~/dev/gbdev/gbdk/bin/lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o bin/main.o src/main.c
~/dev/gbdev/gbdk/bin/lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o bin/dialog.o src/dialog/dialog.c
~/dev/gbdev/gbdk/bin/lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o bin/player.o src/game_states/player.c
~/dev/gbdev/gbdk/bin/lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o bin/maincharacter.o src/game_states/maincharacter.c
~/dev/gbdev/gbdk/bin/lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o bin/world.o src/maps/world.c
~/dev/gbdev/gbdk/bin/lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o bin/grass_tile1.o src/maps/grass_tile1.c
~/dev/gbdev/gbdk/bin/lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o bin/grass_tile2.o src/maps/grass_tile2.c
~/dev/gbdev/gbdk/bin/lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o bin/grass_tile3.o src/maps/grass_tile3.c

# Link everything into final game.gb
~/dev/gbdev/gbdk/bin/lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -o bin/game.gb \
    bin/main.o \
    bin/dialog.o \
    bin/player.o \
    bin/maincharacter.o \
    bin/world.o \
    bin/grass_tile1.o \
    bin/grass_tile2.o \
    bin/grass_tile3.o

# Open in SameBoy (if you want automatic launching)
# open bin/game.gb