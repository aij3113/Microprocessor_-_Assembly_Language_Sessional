Title: Clear the 2nd Column of a 4*4 2D Array.

.MODEL SMALL
.STACK 100H
.DATA
    ARRAY DW 0,1,2,3
          DW 4,5,6,7
          DW 8,9,10,11
          DW 12,13,14,15
 
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    MOV SI,2
    XOR BX,BX
    MOV CX,4
    
    CLR:
        MOV ARRAY[BX][SI],0
        ADD BX,8
        LOOP CLR
    
    MOV AH,4CH
    INT 21H
    
    MAIN ENDP

END MAIN


