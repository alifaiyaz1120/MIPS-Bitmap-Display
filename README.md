# MIPS Program for Drawing a Square on Bitmap Display

## Description
This MIPS assembly program is designed to draw a shape on a 2D bitmap display using the MARS simulator. 

## Inputs
The input to the program is expected to be the assembly language version of the following C structure:

```c
struct projInput {
    unsigned w, h, d;       // size parameters
    unsigned chr, chg, chb; // red-green-blue components for color ch
    unsigned cdr, cdg, cdb; // red-green-blue components for color cd
};
```
## Requirements
- MARS MIPS simulator or another MIPS emulator.
  
## Bitmap Display Setup
- To visualize the output, use the MARS simulator Bitmap Display. Follow these steps:
      - Select Tools → Bitmap Display.
      - Click the "Connect to MIPS" button.
      - Assemble and run your program.

## Links:
- https://courses.missouristate.edu/kenvollmar/mars/download.htm
  
<img width="892" alt="Screenshot 2023-12-15 at 11 59 54 PM" src="https://github.com/alifaiyaz1120/MIPS-Project/assets/119764873/08b28ed5-7b5c-49f6-98af-a2a252428b90">
<img width="777" alt="Screenshot 2023-12-16 at 12 00 07 AM" src="https://github.com/alifaiyaz1120/MIPS-Project/assets/119764873/467c0654-fc43-4bd0-8e0e-b92cc47bc212">
