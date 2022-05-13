TITLE For Loop Implementation 1
Include Irvine32.inc

.data
array DWORD 1,2,3,4,5,6,7,8,9,10
sum DWORD 0
i DWORD 0
.code

COMMENT !
int sum=0;
for ( int i=0; i<10; i++ ){
 sum += array[i];
}
printf("%d",sum)
!

main PROC

;initialization
mov eax,0 ; sum
mov esi,0 ; counter

;jump condition
jmp COND

LOOP1:
;body
add eax,[array+esi*4]

; step
inc esi

;condition
COND:
cmp esi,10
jb LOOP1

EXIT1:

call WriteInt
mov sum,eax


exit
main ENDP
END main