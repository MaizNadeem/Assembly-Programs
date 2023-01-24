	ORG 100h

	.DATA

		ROWS	DW	9
		HALF	DW	0
		OUTTER	DW  0
		INNER	DW  0
		COUNT   DW  0

	.CODE

	MAIN PROC

		MOV COUNT, 1
		MOV AX, ROWS
		SHR AX, 1
		MOV OUTTER, AX
		INC AX
		MOV HALF, AX
		MOV INNER, 1
		MOV AH, 2

	L1:		MOV CX, OUTTER
			MOV DL, ' '

	H1:		CMP CX, 0
			JE  OUT1
			INT 21h
			DEC CX
			JMP H1


	OUT1:	MOV DL, '*'
			INT 21h

			MOV DL, 10
			INT 21h
			MOV DL, 13
			INT 21h

			INC COUNT
			DEC OUTTER


	L2:		MOV CX, OUTTER
			MOV DL, ' '


	H2:		CMP CX, 0
			JE  OUT2
			INT 21h
			DEC CX
			JMP H2


	OUT2: 	MOV DL, '*'
			INT 21h 
			MOV CX, INNER
			MOV DL, ' '


	H3:		INT 21h
			LOOP H3
			MOV DL, '*'
			INT 21h
			MOV DL, 10
			INT 21h
			MOV DL, 13
			INT 21h

			INC COUNT
			DEC OUTTER
			ADD INNER, 2

			MOV DX, HALF
			CMP COUNT, DX
			JLE L2

			INC OUTTER
			SUB INNER, 2


	L3:		INC OUTTER
			SUB INNER, 2
			MOV CX, OUTTER
			MOV DL, ' '


	H4:		CMP CX, 0
			JE  OUT3
			INT 21h
			DEC CX
			JMP H4

	OUT3:	MOV DL, '*'
			INT 21h
			MOV CX, INNER
			MOV DL, ' '

	H5:		INT 21h
			LOOP H5
			MOV DL, '*'
			INT 21h

			MOV DL, 10
			INT 21h
			MOV DL, 13
			INT 21h

			INC COUNT

			MOV DX, ROWS
			DEC DX
			CMP COUNT, DX
			JLE L3

			INC OUTTER
			MOV CX, OUTTER
			MOV DL, ' '

	H6:		INT 21h
			LOOP H6

			MOV DL, '*'
			INT 21h

	RET

	MAIN ENDP