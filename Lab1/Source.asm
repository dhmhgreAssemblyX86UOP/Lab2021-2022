TITLE Mean Value
INCLUDE Irvine32.inc

.data
array WORD 10,20,30,40,50,60,70,80
.code
main PROC

; sum =0;
; for ( int i =0; i<8; i++ ){
;	sum += array[i];
; }
; average = sum /8;
; EAX : sum
; ESI : i

mov AX,0
mov ECX,8
mov ESI,0
L1:
ADD AX,[array+ESI*2]   ; destination = destination + source
INC ESI
LOOP L1 
movzx EAX,AX
shr AX,3







exit
main ENDP
END main