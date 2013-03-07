; Zachary Tschirhart
; zst75
; Thursday 10-11am
; Comments are beside the code

.ORIG  x3000
LD R1, IN1      ;R1 = A
LD R2, IN2      ;R2 = B

; your code goes here

NOT R4, R1      ;R4 = NotA
NOT R5, R2      ;R5 = NotB

AND R6, R1, R5  ;R6 = A and NotB
AND R7,  R4, R2 ;R7 = NotA and B

NOT R6, R6      ;NOT R6
NOT R7, R7      ;NOT R7

AND R3, R6, R7  ;R3 = R6 AND R7
NOT R3, R3      ;NOT R3

; assuming your result is in R3
ST R3, XOR
HALT
IN1 .FILL 5862
IN2 .FILL 9426  ;Should equal 12852
XOR .BLKW 1
 .END