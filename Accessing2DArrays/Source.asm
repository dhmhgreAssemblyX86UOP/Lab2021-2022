TITLE Accessing 2D arrays
INCLUDE Irvine32.inc

.data
;array2D DWORD 10h,20h,30h,40h,
;			  50h,60h,70h,80h,
;			  90h,100h,110h,120h,
;			  130h,140h,150h,160h
;ROWSIZE EQU ($-array2D)/ ( TYPE array2D *4)

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

.code
main PROC

exit
main ENDP
END main00000004
