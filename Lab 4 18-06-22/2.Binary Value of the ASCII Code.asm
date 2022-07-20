Title: BINARY & HEXA OF INPUT

.MODEL SMALL
.STACK 100H
.DATA
    MSG1 DB 'ENTER A KEY: $'
    MSG2 DB 'THE BINARY OF THE ASCII VALUE OF THE INPUT IS: $'
    MSG3 DB 'THE HEXA OF THE ASCII VALUE OF THE INPUT IS: $'
    MSG4 DB 'NUMBER OF 1 IN THE BINARY IS: $'

        
.CODE
MAIN PROC 
    MOV AX,@DATA
    MOV DS,AX
   
    
    LEA DX,MSG1
    MOV AH,9
    INT 21H
    
    MOV AH,1
    INT 21H
    MOV BL,AL
    
    MOV CX,8
              
    MOV AH,2
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H
    
    LEA DX,MSG2
    MOV AH,9
    INT 21H
    
    XOR BH,BH
    
    TOP:        
        SHL BL,1
        JNC ZERO
        ADD BH,1
        MOV DL,'1'
        MOV AH,2
        INT 21H
        JMP LOOP1
        
        ZERO:
            MOV DL,'0'
            MOV AH,2
            INT 21H
        LOOP1:
            LOOP TOP
    
       
    MOV AH,2
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H 
    
    LEA DX,MSG4
    MOV AH,9
    INT 21H
    
    MOV AH,2    
    MOV DL,BH
    ADD DL,30H
    INT 21H
    
    
    
        
    MOV AH,4CH
    INT 21H
    
    MAIN ENDP
END MAIN
