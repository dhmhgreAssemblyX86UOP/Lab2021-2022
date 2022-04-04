TITLE Loop Instruction Example ( Embedded Loops )
Include Irvine32.inc

.data

.code
main PROC


mov ecx, 100
L1:

push ecx
mov ecx,10
L2:

push ecx
mov ecx 20
L3:


LOOP L3
pop ecx


LOOP L2
pop ecx





LOOP L1





exit


main ENDP
END main 