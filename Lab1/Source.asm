TITLE Mean Value
INCLUDE Irvine32.inc

.data
array DWORD 10,20,30,40,50,60,70,80
.code
main PROC

; sum =0;
; for ( int i =0; i<8; i++ ){
;	sum += array[i];
; }
; average = sum /8;
; EAX : sum
; ESI : i

mov EAX,0
mov ECX,8
mov ESI,0
L1:
ADD EAX,[array+ESI*4]   ; destination = destination + source
INC ESI
LOOP L1 
shr EAX,3







exit
main ENDP
END main