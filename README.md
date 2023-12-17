# MIPS Bitmap Display

## Description
This MIPS assembly program is designed to draw a shape on a 2D bitmap display using the MARS simulator. 

## Inputs
The input to the program is expected to be the assembly language version of the following C structure:

```c
struct projInput {
    unsigned m, n;       // Dimensions of the shape
    unsigned c1r, c1g, c1b; // Red-green-blue components for color 1
    unsigned c2r, c2g, c2b; // Red-green-blue components for color 2
};
```
## Requirements
- MARS MIPS simulator 
  
## Bitmap Display Setup
- To visualize the output, use the MARS simulator Bitmap Display. Follow these steps:
  
      - Select Tools → Bitmap Display.
      - Click the "Connect to MIPS" button.
      - Assemble and run your program.

## Links:
- https://courses.missouristate.edu/kenvollmar/mars/download.htm
  
<img width="915" alt="Screenshot 2023-12-16 at 11 14 57 PM" src="https://github.com/alifaiyaz1120/MIPS-Project/assets/119764873/a2f06337-c0f6-490c-9c3c-4e31bec0b8bb">
