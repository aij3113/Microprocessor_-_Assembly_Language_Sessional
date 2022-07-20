Title: Store and print  the sum of 1 + 3 + 5 + ... + 21 in BX

.MODEL SMALL
.STACK 100H
.Data   
    VAR DW 0H 
    MSG DB 'SUM OF THE SERIES IS: $'
            
.CODE
MAIN PROC 
        
    CALL SUMMATION
    CALL DIVITION
    CALL PRINT    
        
    MOV AH,4CH
    INT 21H
    
    MAIN ENDP

SUMMATION PROC
    MOV AL,1
    MOV BL,AL
    
    S_LOOP:
        ADD AL,2
        CMP AL,23
        JE S_CLOSE
        ADD BL,AL
        JMP S_LOOP
        
    S_CLOSE:
        MOV AL,BL
        RET        
    
SUMMATION ENDP


DIVITION PROC
    POP BX
    MOV AH,10D
    MOV CX,0H
        
    D_LOOP:
        XOR DL,DL
        CMP AL,0
        JE D_CLOSE
        DIV AH
        PUSH DX
        INC CX
        JMP D_LOOP
        
    D_CLOSE:
        PUSH BX
        RET

DIVITION ENDP

PRINT PROC
    POP BX
    P_LOOP:
        POP DX
        ADD DX,30H
        MOV AH,2
        INT 21H
        LOOP P_LOOP
    
    PUSH BX
    RET

PRINT ENDP    

END MAIN
