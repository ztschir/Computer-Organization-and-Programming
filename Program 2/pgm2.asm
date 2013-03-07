	.ORIG x3000
	
	LD R2, TERMINATE ; Terminate at ‘&’
	LEA R4, STRCHAR ; initialize to first strchar
	LD R5, COUNTER ; initialize the counter

INPUT 	TRAP x23 ; input character
	ADD R1, R2, R0 ; Test for Terminate
	BRz CHKPAL ; Print if '&'
	STR R0, R4, #0 ; store keyboard char
	ADD R4, R4, #1 ; incriment pointer
	ADD R5, R5, #1 ; incriment counter
	;ADD R0, R0, R3 ; Change to lowercase
	BRnzp INPUT 

CHKPAL	LEA R1, STRCHAR ; Beginning of array
	LD R2, COUNTER
	ADD R2, R2, R5
	ADD R2, R1, R2 ; End of array
	ADD R2, R2, #-1
	BRnzp CHKLOOP
	
CHKLOOP	LDR R3, R1, #0 ; Load values
	LDR R4, R2, #0
	NOT R5, R1
	ADD R5, R5, #1
	ADD R5, R2, R5
	BRnz PRTIS ; check and see if we got to the middle;
	NOT R5, R3
	ADD R5, R5, #1
	ADD R5, R5, R4
	ADD R5, R5, #0
	BRn CHKIFLO ; Check to see if it was a lower case
	BRp CHKIFHI ; Check to see if it was a upper case
	BRz INC

INC	ADD R1, R1, #1
	ADD R2, R2, #-1
	BRnzp CHKLOOP
	
CHKIFLO	LD R7, ASCII
	ADD R6, R5, R7
	BRz INC
	BRnp PRTISNOT

CHKIFHI	LD R7, ASCIIU
	ADD R6, R5, R7
	BRz INC
	BRnp PRTISNOT

PRTIS	LEA R0, ISP ; print Palendrome
	TRAP x22
	BRnzp EXIT

PRTISNOT LEA R0, ISNOTP ; print Not a Palendrome
	TRAP x22
	BRnzp EXIT
	
TERMINATE .FILL xFFDA ; Negitive '&'
ASCII 	.FILL x0020 ; lowercase diff
ASCIIU	.FILL xFFE0 ; Uppercase diff
ODD	.FILL #1;
STRCHAR .BLKW #80 ; reserve 80 spaces for input
COUNTER	.FILL #0 ; counter
ISP	.STRINGZ "Is a Palendrome"
ISNOTP	.STRINGZ "Is not a Palendrome"
EXIT 	TRAP x25 ; halt
.END