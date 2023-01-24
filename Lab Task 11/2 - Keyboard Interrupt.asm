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
					MOV SI, (13-5-1)*160 + (40-1)*2

					MOV CX, SIZE
					MOV AH, 0x07
					XOR BX, BX

		NAMEPRINT:	MOV AL, [STR1 + BX]
					MOV ES:SI, AX
					ADD SI, 80*2
					INC BX
					LOOP NAMEPRINT

		PROCCALL:	CMP FLAG, 1
					JNE  SKIP
					CALL DOWN
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


	DOWN PROC

					MOV CX, SIZE
					CMP SI, 1678
					JNE ERASE
					PUSH SI
					MOV SI, (25-1)*160 + (40-1)*2
					MOV ES:SI, 0X0720
					POP SI

		ERASE:		CMP SI, (40-1)*2
					JLE ERASE2
					SUB SI, 80*2
					MOV ES:SI, 0X0720
					LOOP ERASE
					JMP AFTER

		ERASE2:		MOV SI, (25-1)*160 + (40-1)*2
					MOV ES:SI, 0X0720
					JMP ERASE

		AFTER:		MOV CX, SIZE
					MOV BX, 0
					ADD SI, 80*2
					MOV DX, (40-1)*2

		NAMEPRINT2:	CMP SI, 25*160 + (8)*2
					JGE NAMEPRINT3
					MOV AL, [STR1 + BX]
					MOV ES:SI, AX
					ADD SI, 80*2
					INC BX
					LOOP NAMEPRINT2
					RET

		NAMEPRINT3:	MOV SI, DX
					ADD DX, 160
					JMP NAMEPRINT2

					RET
	DOWN ENDP