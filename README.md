# MIPS Program for Drawing a Square on Bitmap Display

## Task Description
The goal of this MIPS program is to draw a square on a 2D bitmap display using the MARS simulator. The program takes input parameters for the size of the display, color components for two different colors (ch and cd), and is expected to draw a specific shape on the bitmap display.

## Input Structure
The input structure is defined in C as follows:
```c
struct projInput {
    unsigned w, h, d; // size parameters
    unsigned chr, chg, chb; // red-green-blue components for color ch
    unsigned cdr, cdg, cdb; // red-green-blue components for color cd
}
```
