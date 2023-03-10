	ORG 100h

	.DATA

		SFLAG	DB  0
		AFLAG	DB	0

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

		PROCCALL:	JMP PROCCALL

	
					RET
	MAIN ENDP
	

			KBISR:	PUSH AX
				 	IN  AL, 0x60
					CMP AL, 0x2A
					JNE CHECK_RELEASE
					MOV SFLAG,1
					JMP KEXIT

	CHECK_RELEASE:	CMP AL, 0xAA
					JNE CHECK_A
					MOV SFLAG, 0
					JMP KEXIT

		  CHECK_A:	CMP AL, 0x1E
					JNE KEXIT
					CMP SFLAG, 1
					JNE KEXIT
					CALL APROC

			KEXIT:	MOV AL, 0x020
					OUT 0x20, AL
					POP AX
					IRET


	APROC PROC

					MOV AX, 0xB800
					MOV ES, AX
					MOV SI, 0
					MOV AH, 0x07

		NAMEPRINT:	MOV AL, 'A'
					MOV ES:SI, AX
					ADD SI, 2

	RET
	APROC ENDP