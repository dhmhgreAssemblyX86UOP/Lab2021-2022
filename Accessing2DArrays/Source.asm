TITLE Accessing 2D arrays
INCLUDE Irvine32.inc

.data
;array2D DWORD 10h,20h,30h,40h,
;			  50h,60h,70h,80h,
;			  90h,100h,110h,120h,
;			  130h,140h,150h,160h
;ROWSIZE EQU ($-array2D)/ ( TYPE array2D *4)

COMMA BYTE ",",0

array2D DWORD 10h,20h,30h,40h
ROWSIZE = ($-array2D) / TYPE array2D
		DWORD 50h,60h,70h,80h
		DWORD 90h,100h,110h,120h
		DWORD 130h,140h,150h,160h
; int a[4][4];
; a[0][1]
; effective address = array2D +offset
; = array2D + numberOfElementsBefore(i,j) * sizeOfElement
; = array2D + (i*ROW_SIZE_IN_ELEMENTS + j) * SIZE_OF_ELEMENT

row BYTE 2
column BYTE 2
;x BYTE 34 Be careful what DWORD PTR DOES
.code
main PROC
movzx eax, row   ; EAX <= 2
shl eax,TYPE array2D/2		 ; EAX <= EAX *4 == i * ROW_SIZE_IN_ELEMENTS
;add eax, DWORD PTR column	 ; Be careful what DWORD PTR DOES
add al, column
shl eax,TYPE array2D/2
mov ebx,[array2D+eax]  ; INDIRECT ADDRESSING
mov ecx,[array2d+40]   ; DIRECT ADDRESSING


mov esi,0  ; esi has the row
mov ecx,4
L1: ; rows

push ecx
mov ecx,4
mov edi,0  ; edi has the column
L2: ; columns
	; effective address (i,j) == (ESI,EDI)
	mov eax, esi     ; EAX <= 2
	shl eax,2		 ; EAX <= EAX *4 == i * ROW_SIZE_IN_ELEMENTS
	add eax, edi
	shl eax,TYPE array2D/2
	mov eax,[array2D+eax]
	call WriteHex
	mov edx, OFFSET COMMA
	call WriteString
	inc edi
LOOP L2
pop ecx
	inc esi
LOOP L1





exit
main ENDP
END main
