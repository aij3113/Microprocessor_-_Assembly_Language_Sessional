Title: Input Small Char Print Capital Char

.MODEL SMALL
.STACK 100H 
.DATA
    MSG1 DB 'Enter the Lowercase Char: $'
    MSG2 DB 'The Uppercase Char is: $'
        
.CODE
MAIN PROC 
    MOV AX,@DATA
    MOV DS,AX
    
    ;For printing MSG1    **LEA & 21H**         
    LEA DX,MSG1
    MOV AH,9
    INT 21H
              
    ;For CHAR Input ** AH = 1 **
    MOV AH,1
    INT 21H
    MOV BL,AL
    
    ;For NEW LINE   ** 0DH & 0AH **
    MOV AH,2
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H
      
    LEA DX,MSG2
    MOV AH,9
    INT 21H
    
    ;For CHAR Output  ** AH = 2 **        
    MOV AH,2
    MOV DL,BL
    SUB DL,32
    INT 21H
    
    MOV AH,4CH
    INT 21H
    
    MAIN ENDP
END MAIN
