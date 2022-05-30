TITLE Variance
INCLUDE Irvine32.inc

.data 



.code
Mean PROC
; prologue
push  ebp
mov ebp, esp
; sub esp, x ( optional )
pushad ; (requires inspections at the end )


; epilogue
popad
mov esp,ebp ; ( cleans local variables )
pop ebp
ret ; x (STDCALL)  (valid only for CDECL calling convention )
Mean ENDP

Variance PROC
; prologue
push  ebp
mov ebp, esp
; sub esp, x ( optional )
pushad ; (requires inspections at the end )


; epilogue
popad
mov esp,ebp ; ( cleans local variables )
pop ebp
ret ; x (STDCALL)  (valid only for CDECL calling convention )
Variance ENDP

main PROC
; prologue
push  ebp
mov ebp, esp
; sub esp, x ( optional )
pushad ; (requires inspections at the end )


exit
main ENDP
END main