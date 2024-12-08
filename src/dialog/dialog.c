#include "../../include/dialog.h"
#include <gb/gb.h>
#include <stdio.h>

UINT8 dialog_state = 0;

void show_dialog(void) {
    switch(dialog_state) {
        case 0:
            printf("\n\n\n\n\n\n\n\n\n\n\nCongratulations!\nYou got hired for a\nBD role!");
            break;
        case 1:
            printf("\n\n\n\n\n\n\n\n\n\n\nGet ready for your\nfirst conference!");
            break;
    }
}

void update_dialog(void) {
    if(joypad() & J_A) {
        dialog_state++;
        if(dialog_state <= 1) {
            show_dialog();
        }
    }
}