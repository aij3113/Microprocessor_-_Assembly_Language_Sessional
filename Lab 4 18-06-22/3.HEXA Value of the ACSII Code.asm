Title: HEXA CODE OF INPUT 

.MODEL SMALL
.STACK 100H
.DATA
    MSG1 DB 'ENTER A KEY: $'
    MSG2 DB 'THE HEXA OF THE ASCII VALUE OF THE INPUT IS: $'

        
.CODE
MAIN PROC 
    MOV AX,@DATA
    MOV DS,AX
   
    ;Print MSG1
    LEA DX,MSG1
    MOV AH,9
    INT 21H
    
    ;Character Input
    MOV AH,1
    INT 21H
    MOV BL,AL
    
    ;Line-Break          
    MOV AH,2
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H
    
    ;Print MSG2
    LEA DX,MSG2
    MOV AH,9
    INT 21H
    
    ;Keep copy of BL in BH
    MOV BH,BL
    
    ;Right-Shift BL 4 times        
    SHR BL,4
    MOV DL,BL
    
    ;Compare if DL & 9
    CMP DL,9
    ;Jump to CHAR part if Greater than 9
    JG CHAR1
    ;Add 30H for 0-9
    ADD DL,30H
    JMP PRINT1
    
    CHAR1:
    ;Add 31H for A-F
    ADD DL,31H
    
    PRINT1:
    ;Print First Value  
    MOV AH,2
    INT 21H
    
    ;Get the Copyed value of Input
    MOV BL,BH
    ;AND '00001111' for last 4 bits    
    AND BL,0Fh
    
    MOV DL,BL
    ;Compare if DL & 9
    CMP DL,9
    ;Jump to CHAR part if Greater than 9
    JG CHAR2
    ;Add 30H for 0-9
    ADD DL,30H
    JMP PRINT2
    
    CHAR2:
    ;Add 31H for A-F
    ADD DL,31H
    
    PRINT2:
    ;Print Second Value  
    MOV AH,2
    INT 21H
    
     
    MOV AH,4CH
    INT 21H
    
    MAIN ENDP
END MAIN
