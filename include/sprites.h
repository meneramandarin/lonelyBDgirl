#ifndef SPRITES_H
#define SPRITES_H

// Girl character sprite - front facing
const unsigned char girlSprite[] = {
    // Top left - head/hair
    0x3C,0x3C,  // 00111100 - hair outline
    0x7E,0x7E,  // 01111110 - hair/face
    0x6B,0x7F,  // 01101011 - eyes/features
    0x7F,0x7F,  // 01111111 - face detail
    0x3C,0x3C,  // 00111100 - neck
    0x3C,0x3C,  // 00111100 - top of dress
    0x3C,0x3C,  // 00111100 - dress
    0x3C,0x3C,  // 00111100 - dress

    // Top right - head/hair
    0x3C,0x3C,  // 00111100
    0x7E,0x7E,  // 01111110
    0xD6,0xFE,  // 11010110
    0xFE,0xFE,  // 11111110
    0x3C,0x3C,  // 00111100
    0x3C,0x3C,  // 00111100
    0x3C,0x3C,  // 00111100
    0x3C,0x3C,  // 00111100

    // Bottom left - dress
    0x3C,0x3C,  // 00111100 - dress top
    0x7E,0x7E,  // 01111110 - dress middle
    0x7E,0x7E,  // 01111110 - dress
    0x3C,0x3C,  // 00111100 - dress bottom
    0x24,0x3C,  // 00100100 - legs
    0x24,0x3C,  // 00100100 - feet
    0x00,0x00,  // empty
    0x00,0x00,  // empty

    // Bottom right - dress
    0x3C,0x3C,  // 00111100
    0x7E,0x7E,  // 01111110
    0x7E,0x7E,  // 01111110
    0x3C,0x3C,  // 00111100
    0x24,0x3C,  // 00100100
    0x24,0x3C,  // 00100100
    0x00,0x00,  // empty
    0x00,0x00   // empty
};

#endif
