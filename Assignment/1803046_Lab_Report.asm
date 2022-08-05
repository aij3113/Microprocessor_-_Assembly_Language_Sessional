Title:Lab Report 

.MODEL SMALL
.STACK 100H
.Data        
    MSG1 DB 'Enter Your Name in Small Letter: $'
    MSG2 DB 'Name in Capital Letter: $'
    MSG3 DB 'Store your CT Marks of Course CSE 3109 in an Array: $'
    MSG4 DB 'Enter Last 3 Digit of Your Roll Number: $'
    MSG5 DB 'Remainder After Dividing Roll Number by 3: $'
    CS00 DB 'Case 0 Activated.$'
    CS01 DB 'Name  is Palindrome.$'
    CS02 DB 'Name is Not Palindrome.$'
    CS03 DB 'Roll is Palindrome.$'
    CS04 DB 'Roll is Not Palindrome.$'
    CS10 DB 'Case 1 Activated.$'
    CS11 DB 'Average of Best 3 CT Marks: $'
    CS20 DB 'Case 2 Activated.$'
    CS21 DB 'CT Marks After Case 2 Operation: $'    
    ;Name
    NM DB 50 DUP (?) 
    R_NM DB 50 DUP (?)
    NM_SZ DW 0H
    ;CT Marks
    CTM DB 5 DUP (?) 
    ROLL DB ?
    ROLL_ST DB 3 DUP (?)
    R_ROLL_ST DB 3 DUP (?)
    REMAINDER DB ?
    CT_AVG DB 0H
    VAR DW ?
    
    
            
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    MOV ES,AX
     
    
    CALL NAME_INPUT    
    
    CALL NAME_OUTPUT    
     
    CALL CTM_INPUT
    
    CALL ROLL_INPUT    
    
    CALL DIV_ROLL
    
    CALL CASE_CHECK
    
       
    MOV AH,4CH
    INT 21H
    
    MAIN ENDP 


    
    
    
;New line
NL PROC
    MOV AH,2
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H
    
    RET    
NL ENDP    
      
;Name input in small letter 
NAME_INPUT PROC 
    MOV AH,9
    LEA DX,MSG1
    INT 21H
    XOR CX,CX
    LEA DI,NM
    CLD
    MOV AH,1
    
    NAME_IN_LOOP:
        INT 21H
        CMP AL,0DH
        JE NAME_IN_CLOSE
        STOSB
        INC CX
        JMP NAME_IN_LOOP
        
    NAME_IN_CLOSE:
        MOV NM_SZ,CX
        RET            
NAME_INPUT ENDP

;Name output in capital letter 
NAME_OUTPUT PROC
    CALL NL
    MOV AH,9
    LEA DX,MSG2
    INT 21H
    LEA SI,NM
    CLD
    MOV AH,2
    
    NAME_OUT_LOOP:
        XOR DX,DX
        LODSB
        MOV DL,AL
        CMP DL,61H
        JL PRINT
        CMP DL,7AH
        JG PRINT     
        SUB DL,20H
        PRINT:
            INT 21H
        LOOP NAME_OUT_LOOP
        
    NAME_OUT_CLOSE:
        MOV CX,NM_SZ
        RET            
NAME_OUTPUT ENDP

;CT marks input in CTM 
CTM_INPUT PROC
    CALL NL 
    MOV AH,9
    LEA DX,MSG3
    INT 21H
    XOR SI,SI
    XOR BX,BX
    MOV DH,0AH
    
    CTM_IN_LOOP:
        MOV AH,1
        INT 21H
        CMP AL,0DH
        JE CTM_IN_CLOSE
        CMP AL,' '
        JE NEXT
        CMP AL,','
        JE NEXT
        SUB AL,30H
        MOV DL,AL
        MOV AL,BL
        MUL DH
        ADD DL,AL
        MOV BL,DL
        JMP LOOP1
        NEXT:
            MOV CTM[SI],BL 
            XOR BX,BX
            INC SI        
        LOOP1:
            JMP CTM_IN_LOOP
        
    CTM_IN_CLOSE:
        MOV CTM[SI],BL 
        RET            
CTM_INPUT ENDP
 
;Roll number input
ROLL_INPUT PROC
    CALL NL 
    MOV AH,9
    LEA DX,MSG4
    INT 21H
    XOR BX,BX
    LEA DI,ROLL_ST
    CLD
    MOV DH,0AH
    
    ROLL_IN_LOOP:
        MOV AH,1
        INT 21H
        CMP AL,0DH
        JE ROLL_IN_CLOSE
        STOSB
        SUB AL,30H
        MOV DL,AL
        MOV AL,BL
        MUL DH
        ADD DL,AL
        MOV BL,DL
        JMP ROLL_IN_LOOP
        
    ROLL_IN_CLOSE:
        MOV ROLL,BL 
        RET            
ROLL_INPUT ENDP

;Divide roll by 3
DIV_ROLL PROC
    CALL NL
    MOV AX,0H
    MOV AL,ROLL
    MOV BL,3H
    DIV BL
    MOV REMAINDER,AH
    
    MOV AH,9
    LEA DX,MSG5
    INT 21H
    
    MOV DL,REMAINDER
    ADD DL,30H
    MOV AH,2
    INT 21H
    
    RET      
DIV_ROLL ENDP


CASE_CHECK PROC
    MOV BL,REMAINDER
    
    CMP BL,1
    JL CS_0
    JE CS_1
    JG CS_2
    
    CS_0:
        CALL CASE_0
        JMP CASE_END        
    CS_1:
        CALL CASE_1
        JMP CASE_END
    CS_2:
        CALL CASE_2
    
    CASE_END:
        RET
CASE_CHECK ENDP

CASE_0 PROC
    CALL NL
    LEA DX,CS00
    MOV AH,9
    INT 21H
    CALL NL
       
    MOV CX,NM_SZ
    DEC CX 
    LEA SI,NM
    CLD
    REP LODSB
    
    LEA DI,R_NM
    MOV CX,NM_SZ
    STD
    
    MOVE:
        MOVSB
        ADD DI,2H
        LOOP MOVE
        
    MOV CX,2
    LEA SI,ROLL_ST
    CLD
    REP LODSB
    
    LEA DI,R_ROLL_ST
    MOV CX,3
    STD
    
    MOVE2:
        MOVSB
        ADD DI,2H
        LOOP MOVE2                            
    
    MOV CX,3
    LEA SI,ROLL_ST
    LEA DI,R_ROLL_ST
    CLD 
    REPE CMPSB
    MOV AH,9
    JE PM_CS03
    LEA DX,CS04
    INT 21H
    CALL NL
    JMP NM_CMP
    
    PM_CS03:
        LEA DX,CS03
        INT 21H
        CALL NL
    
  NM_CMP:
    LEA SI,NM
    LEA DI,R_NM
    CLD
    REPE CMPSB
    MOV AH,9
    JE PM_CS01
    LEA DX,CS02
    INT 21H
    
    PM_CS01:
        LEA DX,CS01
        INT 21H
        
    
    RET
CASE_0 ENDP
      
      
CASE_1 PROC
    CALL NL
    LEA DX,CS10
    MOV AH,9
    INT 21H
    CALL NL
    
    XOR SI,SI
    XOR DX,DX
    
    MOV CX,4
    MOV AL,CTM[SI]
    
    CT_ADD:
        ADD DL,CTM[SI]
        CMP AL,CTM[SI]
        JLE L_CT_ADD
        MOV AL,CTM[SI]
      L_CT_ADD:
        INC SI
        LOOP CT_ADD
    
    SUB DL,AL
    MOV BL,3
    MOV AX,0
    MOV AL,DL
    DIV BL
    MOV CT_AVG,AL
    
    LEA DX,CS11
    MOV AH,9
    INT 21H
    
    MOV DL,CT_AVG
    XOR AX,AX
    MOV AL,CT_AVG
    
    CALL CTM_DIV
    CALL CTM_PRINT            
    
    
    RET
CASE_1 ENDP


CTM_DIV PROC
    MOV VAR,0H
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

CTM_DIV ENDP

CTM_PRINT PROC
    POP BX 
    
    P_LOOP:
        POP DX
        ADD DX,30H
        MOV AH,2
        INT 21H
        LOOP P_LOOP
    
    PUSH BX
    RET

CTM_PRINT ENDP


CASE_2 PROC
    CALL NL
    LEA DX,CS20
    MOV AH,9
    INT 21H
    CALL NL
    
    XOR SI,SI
    
    MOV AL,CTM[SI]
    MOV BL,CTM[SI]
    INC SI
    MOV CX,3
    
    FIND_MAX_MIN:
        CMP AL,CTM[SI]
        JGE CMP_NEXT
        MOV AL,CTM[SI]
      
      CMP_NEXT:
        CMP BL,CTM[SI]
        JLE END_LOOP
        MOV BL,CTM[SI]
      
      END_LOOP:
        INC SI
        LOOP FIND_MAX_MIN
    
    MOV SI,0H
    MOV CX,4H
    
    REPLACE:
        CMP BL,CTM[SI]
        JNE END_REPLACE
        MOV CTM[SI],AL
      END_REPLACE:
        INC SI
        LOOP REPLACE
    
    LEA DX,CS21
    MOV AH,9
    INT 21H
    
    XOR SI,SI
    MOV DI,4H
    
    ALL_CTM_PRINT:
        XOR AX,AX
        MOV AL,CTM[SI]
        
        CALL CTM_DIV
        CALL CTM_PRINT
        
        INC SI
        DEC DI
        CMP DI,0        
        JE ALL_CLOSE
        MOV AH,2
        MOV DX,','
        INT 21H
        JMP ALL_CTM_PRINT  
    
        
  ALL_CLOSE:  
    RET
CASE_2 ENDP
    

END MAIN
