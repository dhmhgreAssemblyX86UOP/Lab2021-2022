TITLE Variance
INCLUDE Irvine32.inc

.data 
array WORD 10,20,30,40,50,60,70,80,90,100
ARRAYSIZE = ($-array)/TYPE array
message1 BYTE "Mean : ",0 
message2 BYTE "Variance : ",0 
meanres WORD ?
varianceres DWORD ?

.code
;int (EAX) Mean( unsigned short *array, 
;                int size, unsigned short *mean)
Mean PROC
; prologue
push  ebp
mov ebp, esp
; sub esp, x ( optional )
push ebx ; (requires inspections at the end )
push ecx
push edx
push esi
push edi

; body


; update eax with the result (mean )
; epilogue
pop edi
pop esi
pop edx
pop ecx
pop ebx

mov esp,ebp ; ( cleans local variables )
pop ebp
ret ; x (STDCALL)  (valid only for CDECL calling convention )
Mean ENDP

;int (EAX) Variance( unsigned short *array, [EBP+8]
;					 int size ,[EBP+12]
;					 int mean ,[EBP+16]
;					 unsigned int *variance) [EBP+20] 
Variance PROC
; prologue
push  ebp
mov ebp, esp
; sub esp, x ( optional )
push ebx ; (requires inspections at the end )
push ecx
push edx
push esi
push edi

;body

; update eax with the result ( variance )
; epilogue
pop edi
pop esi
pop edx
pop ecx
pop ebx
mov esp,ebp ; ( cleans local variables )
pop ebp
ret ; x (STDCALL)  (valid only for CDECL calling convention )
Variance ENDP

main PROC
; prologue
push  ebp
mov ebp, esp
sub esp, 4 ;( optional )
pushad ; (requires inspections at the end )

;body 

;int (EAX) Mean( unsigned short *array, [EBP+8]
;                int size [EBP+8], unsigned short *mean [EBP+12])
push OFFSET meanres
push ARRAYSIZE
push OFFSET array
call Mean
; CDECL add esp,12
; Print results
mov edx, OFFSET Message1
call WriteString
call WriteInt
call crlf

lea esi,[ebp-4]
push esi
push ARRAYSIZE
push OFFSET array
call Mean
; CDECL add esp,12
mov edx, OFFSET Message1
call WriteString
call WriteInt
call crlf

; Print results

;int (EAX) Variance( unsigned short *array, [EBP+8]
;					 int size ,[EBP+12]
;					 int mean ,[EBP+16]
;					 unsigned int *variance) [EBP+20] 
push OFFSET Varianceres
push eax
push ARRAYSIZE
push OFFSET array
call Variance 
; CDECL add esp,12
; Print results
mov edx, OFFSET Message2
call WriteString
call WriteInt
call crlf


exit
main ENDP
END main