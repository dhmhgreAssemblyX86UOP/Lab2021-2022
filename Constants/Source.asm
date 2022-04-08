TITLE Constants
Include Irvine32.inc
SIZE0 = 1+2*3

SIZE1 EQU 1+2*3
SIZE2 EQU SIZE1
SIZE3 EQU <"1+2*3">

.data
val1 BYTE SIZE1
val2 BYTE "The value is ",SIZE3,0

.code
main PROC
mov edx,OFFSET val2
call WriteString

exit
main ENDP
END main