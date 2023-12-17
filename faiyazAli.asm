.data
frameBuffer: .space 0x80000 # 512 wide X 256 = 131072 * 4 = 524288 pixels
m:	.word  120 #inner
n:	.word  160 #outer
c1r:	.word  255 #inner
c1g:	.word  0 #inner
c1b:	.word  0 #inner
c2r:	.word  0 #outer
c2g:	.word  255 #outer
c2b:	.word  0 #outer
.text
main:
    la $s0, m #$t0 <- address of m
    lw $s0, 0 ($s0) # s0<--m
    la $s1, n #$t0 <- address of n
    lw $s1, 0 ($s1) # s1<--n
    # inner square
    la $t1, c1r  # t1 <-- clr (23:16)
    lw $t1, 0 ($t1)  
    sll $t1, $t1, 16 # shift t1 is 16 places
    la $t2, c1g  # t2 <-- clg (15:8)
    lw $t2, 0 ($t2)  
    sll $t2, $t2, 8 # shift t2 is 8 places
    la $t3, c1b  # t3 <-- clb (7:0)
    lw $t3, 0 ($t3) 
    or $t4, $t3, $t2 # t4 <--- t3 or t2
    or $t4, $t4, $t1 # t4 <--- t4 or t1
    add $s2,$zero,$t4 # s2<--- t4
    # outer square
    la $t1, c2r  # t1 <-- c2r (23:16)
    lw $t1, 0 ($t1)  
    sll $t1, $t1, 16 # shift t1 is 16 places
    la $t2, c2g  # t2 <-- clg (15:8)
    lw $t2, 0 ($t2)  
    sll $t2, $t2, 8 # shift t1 is 16 places
    la $t3, c2b  # t3 <-- clb (7:0)
    lw $t3, 0 ($t3) 
    or $t4, $t3, $t2 # t4 <--- t3 or t2
    or $t4, $t4, $t1 # t4 <--- t4 or t1
    add $s3,$zero,$t4 # s3<--- t4
#Setting up yellowBackground 
    la $t0,frameBuffer #$t0 <- frame bufffer address 
    li $t1, 0x00FFFF00 # t1 <-- yellow
    li $t2, 131072 # t2 <---- 131072 (this is from 512 x 256 pixels)
yellowBackground:
     sw $t1, 0($t0) # store yellow in the pixel
     addi $t0, $t0, 4 # moves the pixel to the right
     addi $t2, $t2, -1 # goes down from t2 (the counter)
     bne $t2, $zero, yellowBackground #if it is not equal to zero, loop back to the yellowBackground  
# Setting edge test cases
     #outer = n ($s1)
     #inner = m ($s0)
     # m > n
      slt $t0, $s1, $s0 # t0 <-- 1 if m < n else 0
      bne $t0, $zero, exit # Exit loop if n doesnt equal to 0   
      # n > 256
      addi $t1,$zero,256 # t1 <--- 256
      slt $t2, $t1, $s1 # t2 <--- 1 if 256 < n else 0
      bne $t2, $zero, exit # Exit loop if n doesnt equal to 0
      #can not be odd
      add $t1, $s0, $zero # t1 <--- m
      add $t2, $s1, $zero  # t2 <--- n
      andi $t1,$t1, 0x0001 # t1 <--- clear the last bit 
      andi $t2,$t2, 0x0001 # t2 <--- clear the last bit 
      bne $t1, $zero, exit # if is t1 doesnt equal to 0
      bne $t2, $zero, exit # if is t2 doesnt equal to 0 
      # m is 0
      beq $s0, $zero, exit # if m is equal to 0, exit
#setting outerSquare
        la $t0,frameBuffer #$t0 <- frame bufffer address
        add $t1, $zero, $s1 # t1 <-- n
        addi $t2, $zero, 512 # t2 <-- 512
        srl  $t2, $t2, 1 # t2 <-- 512/2 = 256
        addi $t3, $zero, 256 # t3 <-- 256
        srl  $t3, $t3, 1 # t3 <--- 256/2 = 128
        srl  $t4, $t1, 1 # t4 <--- n /2
        sub  $t2, $t2, $t4 # t2 <-- 256 - (n/2)
        sub  $t3, $t3, $t4 # t3 <-- 128 - (n/2)
        sll $t2, $t2, 2 # t2 <--- (256 - (n/2)) * 4
        sll $t3, $t3, 11 # t3 <--- (128 - (n/2)) * 2048
        add $t5, $t5, $t1 # t5 <--- n
        add $t6, $t6, $t1 # t6 <--- n
        sll $t7, $t2, 1 # t7 <--- ((256 - (n/2)) * 4) * 2
        add $t0,$t0,$t2 # t0 <---- t2
        add $t0,$t0,$t3 # t0 <---- t3      
outerSquare:
     sw $s3, 0($t0) # store color in the pixel
     addi $t0,$t0, 4 # moves the pixel
     addi $t5, $t5, -1 # decreases a counter
     bne $t5, $zero, outerSquare #if it is not zero, loop back to the outerSquare
     addi $t6, $t6, -1 # goes down t6 for the input for n
     beq $t6, $zero, SetupforlineTopLeft # if equal to 0 jump back to SetupforlineTopLeft
     add $t0, $t0, $t7 # t0 <--- t7
     add $t5, $zero, $t1 # t5 <--- t5 + n (returns back)    
     j outerSquare    
SetupforlineTopLeft:
     la $t0,frameBuffer #$t0 <- frame bufffer address 
     li $t1, 0x00000000 # t1 <-- black				  
     add $t5, $zero, $s1 # t5 <--- n
     add $t0,$t0,$t2 #t0 <--- t2 (getting values back)
     add $t0,$t0,$t3 # t0 <--- t3
lineTopLeft:
     sw $t1, 0($t0) #store black in the pixel
     addi $t0,$t0, 2052 # t0 <--- 2052 (2048 down, 4 right)
     addi $t5, $t5, -1 # goes down t5 value of n
     bne $t5, $zero, lineTopLeft #if it is not zero, loop back to the lineTopLift   
SetupforlineTopRight:
     la $t0,frameBuffer #$t0 <- frame bufffer address 
     li $t1, 0x00000000 # t1 <-- black				  
     add $t5, $zero, $s1 # t5 <--- n
     addi $t9, $s1, -1 # t9 <--- n - 1
     sll $t9,$t9, 2 # t9 <--- (n-1) * 4
     add $t0,$t0,$t2 # t0 <--- t2 
     add $t0,$t0,$t3 # t0 <---- t3 
     add $t0,$t0,$t9 # t0 <--- t9    
lineTopRight:
     sw $t1, 0($t0) #store black in the pixel
     addi $t0,$t0, 2044 # t0 <--- 2044 (2048 down, 4 right)
     addi $t5, $t5, -1 # goes down t5 value of n
     bne $t5, $zero, lineTopRight #if it is not zero, loop back to the lineTopRight           
settingInnerSquare:
      la $t0,frameBuffer #$t0 <- frame bufffer address
      add $t1, $zero, $s0 # t1 <-- m
      addi $t2, $zero, 512 # t2 <-- 512
      srl  $t2, $t2, 1 # t2 <-- 512/2 = 256
      addi $t3, $zero, 256 # t3 <-- 256
      srl  $t3, $t3, 1 # t3 <--- 256/2 = 128
      srl  $t8, $t1, 1 # t4 <--- m /2
      srl  $t4, $t1, 2 # t4 <--- m /4
      sub  $t2, $t2, $t4 # t2 <-- 256 - (m/4)
      sub  $t3, $t3, $t4 # t3 <-- 128 - (m/4)
      sll $t2, $t2, 2 # t2 <--- (256 - (m/4)) * 4
      sll $t3, $t3, 11 # t3 <--- (128 - (m/4)) * 2048
      add $t5, $t5, $t8 # t5 <--- m/2
      add $t6, $t6, $t8 # t6 <--- m/2
      sll $t7, $t2, 1 # t7 <--- ((256 - (m/4)) * 4) * 2
      add $t0,$t0,$t2 # t0 <--- t2
      add $t0,$t0,$t3 # t0 <---- t3
InnerSquare:
     sw $s2, 0($t0) #store color in the pixel
     addi $t0,$t0, 4 # moves the pixel
     addi $t5, $t5, -1 # goes down t5 which is m/2
     bne $t5, $zero, InnerSquare #if it is not zero, loop back to the InnerSquare
     addi $t6, $t6, -1 # goes down t6 which is m/2
     beq $t6, $zero, exit # if t6 is not equal to 0, go to exit
     add $t0, $t0, $t7 # t0 <--- t7
     add $t5, $zero, $t8 # t5 <--- t5 + (m/2) (restores)  
     j InnerSquare        
exit:
li $v0,10 # exit code
syscall # exit to OS    

 
 
 
 