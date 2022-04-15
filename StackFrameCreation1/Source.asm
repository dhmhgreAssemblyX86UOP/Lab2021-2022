TITLE Stack Frame Creation
INCLUDE Irvine32.inc

COMMENT !

int AddFunc(int a, int b, int*sum){
int v[10] = {1,2,3,4,5,6,7,8,9,10};
	*sum = 0;
	*sum = a+b;
}

void main(){
	int sum=0;
	Add(2,3,&sum);	
}



!



.data


.code
AddFunc PROC
; **** Prologue *****
; STEP 3 : Push EBP
push EBP ; Save EBP of caller (main) to the
		 ; center of the current function stack frame
; STEP 4 : Set EBP to the current function 
		  ; stack frame
mov EBP,ESP
; STEP 5 : No local variable thus step is ommited
;sub esp,40 ; allocate space for the array
; STEP 6 : Save registers
push esi

; local array initialization
;mov [ebp-4], DWORD PTR 10
;mov [ebp-8], DWORD PTR 9
;mov [ebp-12], DWORD PTR 8
;mov [ebp-16], DWORD PTR 7
;mov [ebp-20], DWORD PTR 6
;mov [ebp-24], DWORD PTR 5
;mov [ebp-28], DWORD PTR 4
;mov [ebp-32], DWORD PTR 3
;mov [ebp-36], DWORD PTR 2
;mov [ebp-40], DWORD PTR 1

;mov ecx,10
;lea esi,[EBP-40]
;mov edi,0
;mov eax,0
;L1:
;add eax,[esi+edi*4]
;inc edi
;LOOP L1



; *** Function Code ****
;*sum = 0;

;mov [EBP+16], DWORD PTR 0

mov esi,[EBP+16] ; esi now has the address of sum
mov [esi], DWORD PTR 0

;*sum = a+b;
mov eax,[ebp+8]
add eax,[ebp+12]

mov [esi],eax

; **** Epilogue ****
; STEP 1 : Clean Registers
pop esi
; STEP 2 : Clean Local Variables
mov esp,ebp
; STEP 3 : Recover EBP of the caller function
pop ebp
; STEP 4 : Return ( STDCALL )
ret 12
AddFunc ENDP


main PROC
push EBP
mov EBP,ESP
sub ESP,4 ; allocate 4 bytes space in stack for sum 
mov [EBP-4],DWORD PTR 12345678h

; void AddFunc(int a, int b, *sum){
mov eax,ebp ; eax <- EBP
sub eax,4   ; eax <- EBP-4
lea eax,[EBP-4]
; STEP 1 : Push Argument in stack
PUSH eax ; EBP+16
PUSH 3   ; EBP+12
PUSH 2   ; EBP+8
; STEP 2 : Push RETURN ADDRESS in stack
call AddFunc

mov eax, [EBP-4]
call WriteInt


exit
main ENDP
END main 