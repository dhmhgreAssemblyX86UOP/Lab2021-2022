TITLE Create a procedure finding weighted average
INCLUDE Irvine32.inc

; Weighted Average = (Arch_Grade * ECTSArch + MathsGrade * ECTSMath)/(ECTSArch+ECTSMaths)

.data
; ECTS             6             6                  5           5          4
;			  Architecture Programmatismos II,  Statistics, Maths II, Discrete Maths
grades DWORD      800		          900            600        500           700
;                 6x8     +     6x9           +    5x6    +  5x5    +    4x7   / 26
.code

6.00/5 = 1.20 
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


; main body



; epilogue

ret
WeightedAverage ENDP


main PROC
push ebp
mov ebp,esp
sub esp,4
push esi

;int WeightedAverage(int grades[],int N, int *weightedaverage )
push OFFSET grades
push 5
;mov esi,ebp
;sub esi,4  equivalent to lea
lea esi,[ebp-4]  ; indirect addressing [register]
push esi 
call WeightedAverage


pop esi
exit
main ENDP
END main