
	ORG 100H

	.DATA

		N		DB	0
		COLS	DB  0
		LEFT	DB  0
		RIGHT	DB  0

	.CODE

	MOV AH, 1
	INT 21H
	MOV COLS, AL

	ADD COLS, AL