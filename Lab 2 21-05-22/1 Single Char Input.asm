.MODEL SMALL
.STACK 100H
.CODE
MAIN PROC   
    
    ;DISPLAY ?
    
    MOV AH,2
    MOV DL,'?'
    INT 21H
    MOV AH,2
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H
              
    ;INPUT A CHAR
              
    MOV AH,1
    INT 21H
    MOV BL,AL
    
    ;GO TO NEW LINE
    
    MOV AH,2
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H
    
    ;DISPLAY CHAR
    
    MOV DL,BL
    INT 21H
    
    ;RETURN TO DOS
    
    MOV AH,4CH
    INT 21H
    
    MAIN ENDP
END MAIN

