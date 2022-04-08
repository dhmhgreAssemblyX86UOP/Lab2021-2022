TITLE Mean Value
INCLUDE Irvine32.inc

;STATIC MEMORY
;$->     10      10
;		$->     20
;		        $->
;ARRAY_LENGTH = $ - array =2 -0= 2

;array1 BYTE 10,20,30,40
;$
;
;
;



;H e l l o W o r l d !  !  !  0    ODD
;0 1 2 3 4 5 6 7 8 9 10 11 12 13
;            ^
;H e l l o W o r l d !  !  0	   EVEN
;0 1 2 3 4 5 6 7 8 9 10 11 12


.data
array BYTE 10,20,30,40
LENGTH_ARRAY=$-array
message BYTE "HelloWorld!!!",0
LENGTH_MESSAGE = $-message-1

.code
main PROC

mov ECX,LENGTH_MESSAGE
shr ECX,1
mov ESI,0
mov EDI,LENGTH_MESSAGE-1
L1:
mov AL,[message+esi*1]
; AL = 'H'
; XCHG  'H' <-> !
;
XCHG AL,[message+edi*1] 
mov [message+esi*1],al
inc esi
dec edi
LOOP L1
mov edx,OFFSET message
call WriteString
exit
main ENDP
END main