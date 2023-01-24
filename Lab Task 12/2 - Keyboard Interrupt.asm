	ORG 100h

	.DATA

		STR1 	DB 	'MAIZ NADEEM$'
		SIZE 	DW	11
		KFLAG	DB	0
		FLAG	DB	0

	.CODE

	MAIN PROC

					MOV BX, 0
					MOV ES, BX
					
					CLI
					MOV ES:[0x9*4], OFFSET [KBISR]
					MOV ES:[0x9*4+2], CS
					STI


					MOV AH, 0
					MOV AL, 3
					INT 10h

					MOV AX, 0xB800
					MOV ES, AX
					MOV SI, (13-1)*160 + (5-1)*2

					MOV CX, SIZE
					MOV AH, 0x07
					XOR BX, BX

		NAMEPRINT:	MOV AL, [STR1 + BX]
					MOV ES:SI, AX
					ADD SI, 2
					INC BX
					LOOP NAMEPRINT

		PROCCALL:	CMP FLAG, 1
					JNE  SKIP
					CALL LEFT
			SKIP:	JMP PROCCALL
	
					RET
	MAIN ENDP

			KBISR:	PUSH AX
				 	IN  AL, 0x60
					CMP AL, 0x19
					JNE KNEXTCOMP
					MOV KFLAG, 1

	    KNEXTCOMP: 	CMP KFLAG, 1
	    			JNE KEXIT
	    			CMP AL, 0x99
	    			JNE KEXIT
	    			MOV KFLAG, 0
	    			CMP FLAG, 1
	    			JE  CHECK2
	    			MOV FLAG, 1
	    			JMP KEXIT

	       CHECK2:	MOV FLAG, 0

			KEXIT:	MOV AL, 0x20
					OUT 0x20, AL
					POP AX
					IRET


	LEFT PROC

					MOV CX, SIZE

		ERASE:		CMP SI, 1920
					JLE ERASE2
					SUB SI, 2
					MOV ES:SI, 0X0720
					LOOP ERASE
					JMP AFTER

		ERASE2:		MOV SI, 2078
					MOV ES:SI, 0X0720
					JMP ERASE

		AFTER:		MOV CX, SIZE
					MOV BX, 0
					SUB SI, 2
					MOV DX, 1920

					CMP SI, 1918
					JNE  NAMEPRINT2
					MOV SI, 2078

		NAMEPRINT2:	CMP SI, 2080
					JGE NAMEPRINT3
					MOV AL, [STR1 + BX]
					MOV ES:SI, AX
					ADD SI, 2
					INC BX
					LOOP NAMEPRINT2
					RET

		NAMEPRINT3:	MOV SI, DX
					SUB DX, 2
					JMP NAMEPRINT2

					RET
	LEFT ENDP