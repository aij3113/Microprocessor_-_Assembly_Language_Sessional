Title: Take a string from user_and_reverse it.

.MODEL SMALL
.STACK 100H
.DATA   
    MSG1 DB 'Enter String: $'
    MSG2 DB 'Reversed String: $'
    ST DB 50 DUP (?)
    R_ST DB 50 DUP (?)
    ST_SIZE DW 0H
    
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX 
    MOV ES,AX          
    
    CALL ST_INPUT
    CALL ST_REV
    CALL ST_OUTPUT
    
    MOV AH,4CH
    INT 21H
    
    
    MAIN ENDP 

;Sting Input
ST_INPUT PROC 
    MOV AH,9
    LEA DX,MSG1
    INT 21H
    XOR CX,CX
    LEA DI,ST
    CLD
    MOV AH,1
    
    ST_IN_LOOP:
        INT 21H
        CMP AL,0DH
        JE ST_IN_CLOSE
        STOSB
        INC CX
        JMP ST_IN_LOOP
        
    ST_IN_CLOSE:
        MOV ST_SIZE,CX
        RET            
ST_INPUT ENDP

;Reverse String
ST_REV PROC
    DEC CX 
    LEA SI,ST
    CLD
    REP LODSB
    
    LEA DI,R_ST
    MOV CX,ST_SIZE
    STD
    
    MOVE:
        MOVSB
        ADD DI,2H
        LOOP MOVE
        
    MOV CX,ST_SIZE
    RET
ST_REV ENDP
    

;String Output 
ST_OUTPUT PROC
    CALL NL
    MOV AH,9
    LEA DX,MSG2
    INT 21H
    LEA SI,R_ST
    CLD
    MOV AH,2
    
    ST_OUT_LOOP:
        XOR DX,DX
        LODSB
        MOV DL,AL         
        INT 21H
        LOOP ST_OUT_LOOP
        
    ST_OUT_CLOSE:
        RET            
ST_OUTPUT ENDP


;New line
NL PROC
    MOV AH,2
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H
    
    RET    
NL ENDP        


END MAIN