TITLE BubbleSort From Geeks 4 Geeks ( Calling Convention : CDECL )
INCLUDE Irvine32.inc

.data
;    char arr[] = { 64, 34, 25, 12, 22, 11, 90 };
array BYTE 64h, 34h, 25h, 12h, 22h, 11h, 90h
;    int n = sizeof(arr) / sizeof(arr[0]);
ARRAYSIZE = ($-array)/TYPE array
message BYTE "Sorted array:",0
message1 BYTE "Initial array:",0
keno BYTE " ",0
.code

;void swap(int* xp, int* yp)
;{
;    int temp = *xp;
;    *xp = *yp;
;    *yp = temp;
;}
swap PROC
;prologue
push ebp
mov ebp,esp
pushad

;body
mov esi,[ebp+8] ; esi has the address of a
mov edi,[ebp+12] ; edi has the address of b
mov eax,[esi] ; indirect addressing to transfer a to eax
mov ebx,[edi] ; mov *b to *a
mov [esi],ebx ; //
mov [edi],eax   ; mov *a to *b

;epilogue
popad
mov esp,ebp
pop ebp
ret ; now we are using CDECL convention
swap ENDP
 
;// A function to implement bubble sort
;void bubbleSort(int arr[], int n)
;{
;   int i, j;
;    for (i = 0; i < n - 1; i++)
; 
;        // Last i elements are already in place
;        for (j = 0; j < n - i - 1; j++)
;            if (arr[j] > arr[j + 1])
;                swap(&arr[j], &arr[j + 1]);
;}
; 
bubblesort PROC
;prologue 
push ebp
mov ebp,esp
pushad

;body


;loop initialization
mov ecx,0 ; i=0;
mov edx,[ebp+12] ; edx has the size of array
dec edx			 ; edx has the size of array -1
mov edi,[ebp+8] ; edi has the base address of input array
jmp COND1
LOOP1:
;body
	;loop initialization
	mov ebx,0 ; j=0
	jmp COND2
	LOOP2:
	;body
	;if (arr[j] > arr[j + 1])
	;swap(&arr[j], &arr[j + 1]);
	push ecx 
	push edx
	; free registers eax,esi,ecx,edx

	mov eax,edi
	add eax,ebx ; eax has &arr[j]

	mov esi,eax
	inc esi     ; eax has &arr[j+1]

	;if (arr[j] > arr[j + 1])
	mov ecx,[esi] ; ecx has arr[j + 1]
	cmp [eax],ecx
	jle EXIT1
		;swap(&arr[j], &arr[j + 1]);
		push esi
		push eax
		call swap
		add esp,8
	EXIT1:

	pop edx
	pop ecx		

	;step
	inc ebx
	COND2:
	;condition
	;j < n - i - 1  eax
	mov eax, edx ; eax has size of array -1
	sub eax, ecx ; eax has the size of array -i-1;
	cmp ebx,eax
	jl LOOP2
;step
inc ecx
COND1:
;condition
cmp ecx,edx
jl  LOOP1








;epilogue
popad
mov esp,ebp
pop ebp
ret ; ( CDECL calling convention no argument required )
bubblesort ENDP






;/* Function to print an array */
;void printArray(int arr[], int size)
;{
;    int i;
;    for (i = 0; i < size; i++)
;        printf("%d ", arr[i]);
;    printf("\n");
;}
; 
printarray PROC
;prologue
push ebp
mov ebp,esp
pushad

;body



; loop initialization
mov ecx,0   ;i=0
mov esi,[ebp+8] ; esi = &array esi has the base address of array
jmp COND
LOOP1:
 ;loop body
 mov eax,[esi+ecx*4]    ; arr[i] -> eax (indirect addressing)
 call WriteInt
 mov edx, OFFSET keno
 call WriteString
 ;step i++
 inc ecx
 ;condition
COND:
 cmp ecx, [ebp+12]  ; i<size
 jl LOOP1



;epilogue
popad
mov esp,ebp
pop ebp
ret ; now we are using CDECL callingg convention
printarray ENDP


;// Driver program to test above functions
;int main()
;{
;    int arr[] = { 64, 34, 25, 12, 22, 11, 90 };
;    int n = sizeof(arr) / sizeof(arr[0]);
;    bubbleSort(arr, n);
;    printf("Sorted array: \n");
;    printArray(arr, n);
;    return 0;
;}
main PROC

;    printf("Sorted array: \n");
 mov edx, OFFSET message1
 call WriteString
 call Crlf ; prints a newline to screen

 push ARRAYSIZE
 push OFFSET array
 call printarray
 add esp,8 ; mandatory for CDECL calling convention (2 arguments X 4 bytes = 8 bytes )

;    bubbleSort(arr, n);
 push ARRAYSIZE
 push OFFSET array
 call bubblesort
 add esp,8 ; mandatory for CDECL calling convention (2 arguments X 4 bytes = 8 bytes )

 ;    printf("Sorted array: \n");
 mov edx, OFFSET message
 call WriteString
 call Crlf ; prints a newline to screen

 push ARRAYSIZE
 push OFFSET array
 call printarray
 add esp,8 ; mandatory for CDECL calling convention (2 arguments X 4 bytes = 8 bytes )




exit
main ENDP
END main
