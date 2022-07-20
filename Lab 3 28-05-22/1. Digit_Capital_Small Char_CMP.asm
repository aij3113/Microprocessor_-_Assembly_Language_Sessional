Title: Digit / Capital Char / Small Char

.MODEL SMALL
.STACK 100H 
.DATA
    MSG1 DB 'Enter Input: $'
    MSG2 DB 'ITS A DIGIT.$'
    MSG3 DB 'ITS CAPITAL LETTER.$'
    MSG4 DB 'ITS SMALL LETTER.$'
    MSG5 DB 'ITS NOT A DIGIT OR A LETTER.$'
        
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
    
    ;Condition for DIGIT
    CMP BL,'0'
    JNGE BELLOW
    CMP BL,'9'
    JNLE CMP2
    
    ;For printing MSG2    **LEA & 21H**         
    LEA DX,MSG2
    MOV AH,9
    INT 21H
    JMP CLOSE
    
    ;Condition for Capital Letter
    CMP2:
        CMP BL,'A'
        JNGE BELLOW
        CMP BL,'Z'
        JNLE CMP3
               
    SMC:
        ;For printing MSG3    **LEA & 21H**         
        LEA DX,MSG3
        MOV AH,9
        INT 21H 
        JMP CLOSE 
       
       
    ;condition for Small Letter
    CMP3:
        CMP BL,'a'
        JNGE BELLOW
        CMP BL,'z'
        JNLE BELLOW
               
    CPC:
        ;For printing MSG4    **LEA & 21H**         
        LEA DX,MSG4
        MOV AH,9
        INT 21H
        JMP CLOSE
         
    BELLOW:    
        ;For printing MSG5    **LEA & 21H**         
        LEA DX,MSG5
        MOV AH,9
        INT 21H
    
    
    CLOSE:
        
    MOV AH,4CH
    INT 21H
    
    MAIN ENDP
END MAIN
