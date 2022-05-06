TITLE Create a procedure finding weighted average
INCLUDE Irvine32.inc

; Weighted Average = (Arch_Grade * ECTSArch + MathsGrade * ECTSMath)/(ECTSArch+ECTSMaths)

.data
; ECTS             6             6                  5           5          4         = 26
;			  Architecture Programmatismos II,  Statistics, Maths II, Discrete Maths
grades DWORD      800	,	          900  ,          600 ,       500  ,         700 
;                 6x8     +     6x9           +    5x6    +  5x5    +    4x7   / 26   = 18500
; average 7.11
.code

;6.00/5 = 1.20 
;Floating Point XXXXX XXX         25,543587465*10^40
;Fixed point    XXXXXXXX          25,5349834734897358347
; int WeightedAverage(int grades[],int N, int *weightedaverage ){
; int ECTS[5] = { 6,6,5,5,4};
; int sumcoef=0, sum=0;
; 
; for ( int i =0; i<N;i++){
;    sumcoef += ECTS[i];
;    sum += ECTS[i] * grades[i];
; }
;  *weightedaverage = sum/sumcoef;
;  return *weightedaverage; 
;
;}
; void main(){
;    int weightedaverage=0;
;    weightedaverage(grades,5,&weightedaverage);
;}
;
;
;
;
;


WeightedAverage PROC
; prologue
push ebp
mov ebp,esp
sub esp,24 

pushad
mov [ebp - 4],DWORD PTR 0 ;sum of ects

mov [ebp - 8],DWORD PTR 4
mov [ebp - 12],DWORD PTR 5
mov [ebp - 16],DWORD PTR 5
mov [ebp - 20],DWORD PTR 6
mov [ebp - 24],DWORD PTR 6



; main body
mov ecx,5
mov ebx,0 ;sum of ects
lea esi,[ebp - 24]
L1 :    ;find sum of coef
    add ebx,[esi]
add esi,4
LOOP L1
mov [ebp - 4],ebx

 

mov ecx,5
mov ebx,0              ;sum of products
mov edi,[ebp + 8] ;adress grades array
lea esi,[ebp - 24]
L2:
    mov eax,[edi]
    mul DWORD PTR [esi]
    add ebx,eax
add edi,4
add esi,4
LOOP L2

mov eax,ebx
div DWORD PTR [ebp-4]

mov esi,[ebp+16]
mov [esi],eax

; epilogue
popad
mov esp,ebp
pop ebp

 

ret 12 ;3*4
WeightedAverage ENDP


main PROC
push ebp
mov ebp,esp
sub esp,4
push esi

;int WeightedAverage(int grades[],int N, int *weightedaverage )
;mov esi,ebp
;sub esi,4  equivalent to lea
lea esi,[ebp-4]  ; indirect addressing [register]
push esi ; EBP+16
push 5   ; EBP+12
push OFFSET grades  ; EBP+8

call WeightedAverage

mov eax,[ebp-4]
call WriteInt

pop esi
exit
main ENDP
END main