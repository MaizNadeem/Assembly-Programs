	ORG 100h

	.DATA

		STR1 	DB 	'MAIZ NADEEM'
		SIZE 	DW	11

	.CODE

	MAIN PROC

		MOV AX, 0XB800
		MOV ES, AX
		MOV SI, (13-5-1)*160 + (40-1)*2

		MOV CX, SIZE
		MOV AH, 0X07
		XOR BX, BX

		NAMEPRINT:	MOV AL, [STR1 + BX]
					MOV ES:SI, AX
					ADD SI, 80*2
					INC BX
					LOOP NAMEPRINT

		PROCCALL:	CALL DOWN
					LOOP PROCCALL
		 
	MAIN ENDP
	RET

	DOWN PROC

		MOV CX, SIZE

		ERASE:		SUB SI, 80*2
					MOV ES:SI, 0X0720
					LOOP ERASE

					MOV CX, SIZE
					MOV BX, 0
					ADD SI, 2
					CMP SI, 1280
					JGE	SHIFTLEFT

		NAMEPRINT2:	MOV AL, [STR1 + BX]
					MOV ES:SI, AX
					ADD SI, 80*2
					INC BX
					LOOP NAMEPRINT2
	RET

		SHIFTLEFT:	MOV SI, (13-5-1)*160

		NAMEPRINT3:	MOV AL, [STR1 + BX]
					MOV ES:SI, AX
					INC BX
					ADD SI, 80*2
					LOOP NAMEPRINT3

	DOWN ENDP

	RET