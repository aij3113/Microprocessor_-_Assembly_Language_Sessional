Title: Write a code that will store the sum of 1 + 3 + 5 + ... + 21 in BX

.MODEL SMALL
.STACK 100H
        
.CODE
MAIN PROC 
    MOV AL,1
    MOV BL,AL
    
    LOOP1:
        ADD AL,2
        CMP AL,23
        JE CLOSE
        ADD BL,AL
        JMP LOOP1
    
    
    CLOSE:
    MOV AH,2
    MOV DL,BL
    INT 21H
        
    MOV AH,4CH
    INT 21H
    
    MAIN ENDP
END MAIN
