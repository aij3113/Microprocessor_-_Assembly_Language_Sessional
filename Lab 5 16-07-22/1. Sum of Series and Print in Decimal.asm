Title: Store and print  the sum of 1 + 3 + 5 + ... + 21 in BX

.MODEL SMALL
.STACK 100H
.Data   
    VAR DW 0H 
    MSG DB 'SUM OF THE SERIES IS: $'
            
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
     
        
    CALL SUMMATION
    CALL DIVITION
    CALL PRINT    
        
    MOV AH,4CH
    INT 21H
    
    MAIN ENDP

SUMMATION PROC
    MOV AX,1
    MOV BX,AX
    
    S_LOOP:
        ADD AX,2
        CMP AX,23
        JE S_CLOSE
        ADD BX,AX
        JMP S_LOOP
        
    S_CLOSE:
        MOV AX,BX
        RET        
    
SUMMATION ENDP


DIVITION PROC
    POP CX
    MOV BX,10D
        
    D_LOOP:
        XOR DX,DX
        CMP AX,0
        JE D_CLOSE
        DIV BX
        PUSH DX
        INC VAR
        JMP D_LOOP
        
    D_CLOSE:
        PUSH CX
        MOV CX,VAR
        RET

DIVITION ENDP

PRINT PROC
    POP BX 
    
    MOV AH,9
    LEA DX,MSG
    INT 21H
    
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
