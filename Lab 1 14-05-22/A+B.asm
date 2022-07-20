.MODEL SMALL
.STACK 100H
.DATA

A DW 2H
B DW 5H
SUM DW ?
              
              
              
              
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    MOV AX,A        ;AX HAS 2
    ADD AX,B        ;AX = AX + B
    MOV SUM,AX
    
    MOV AX,4C00H
    INT 21H  
    
    MAIN ENDP

END MAIN 


