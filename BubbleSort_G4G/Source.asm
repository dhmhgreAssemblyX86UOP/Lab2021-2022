TITLE BubbleSort From Geeks 4 Geeks ( Calling Convention : CDECL )
; https://www.geeksforgeeks.org/bubble-sort/#:~:text=Bubble%20Sort%20is%20the%20simplest,time%20complexity%20is%20quite%20high.
INCLUDE Irvine32.inc

.data
;    char arr[] = { 64, 34, 25, 12, 22, 11, 70 };
array SBYTE 64h, 34h, -25h, 12h, 22h, 11h, 70h
;    int n = sizeof(arr) / sizeof(arr[0]);
ARRAYSIZE = ($-array)/TYPE array
;apparently bubblesort doesn't work properly and overwrites 
; message variables's contents
;test1 variable hides problem of overwritting message1 by
;being in middle between array and message variable
test1 BYTE 10 DUP(0)
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
mov al,[esi] ; indirect addressing to transfer a to eax
mov bl,[edi] ; mov *b to *a
mov [esi],bl ; //
mov [edi],al   ; mov *a to *b

;epilogue
popad
mov esp,ebp
pop ebp
ret ; now we are using CDECL convention
swap ENDP
 
;// A function to implement bubble sort
;void bubbleSort(int arr[], int n)
;{
;   int i, j;                             range j         [0..5]   [0..4]   [0..3]   [0..2]  [0..1]    [0..0]
;    for (i = 0; i < n - 1; i++)   // starting point i  0        1        2        3       4         5
;    In each iteration the algorithm moves the maximum value to the 
;    highest possible rightmost position
;     i=0 moves 7 to the highest possible rightmost position
;    {5, 7, 4, 2, 1}, ; =1
;	 {5, 7, 4, 2, 1}, j =2
;	 {5, 4, 7, 2, 1}, j = 3
;	 {5, 4, 2, 7, 1}, j = 4
;	 {5, 4, 2, 1, 7}, j = 5
;     i=1 moves 5 to the highest possible rightmost position
;    {4, 5, 2, 1, 7}, ; =1
;	 {4, 2, 5, 1, 7}, j =2
;	 {4, 2, 1, 5, 7}, j = 3
;	 {4, 2, 1, 5, 7}, j = 4
;     i=2 moves 4 to the highest possible rightmost position
;    {2, 4, 1, 5, 7}, ; =1
;	 {2, 1, 4, 5, 7}, j =2
;	 {2, 1, 4, 5, 7}, j = 3
;     i=3 moves 2 to the highest possible rightmost position
;    {1, 2, 4, 5, 7}, ; =1
;	 {1, 2, 4, 5, 7}, j =2
;	 
;    
;   
;                                  
;        // Last i elements are already in place
;        for (j = 0; j < n - i - 1; j++)  // range in the new interval
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
dec edx			 ; edx has the size of array -1 (i = 0; i < n - 1; i++)
mov edi,[ebp+8] ; edi has the base address of input array
jmp COND1
LOOP1:
;    i=0 moves 7 to the highest possible rightmost position
;    {5, 7, 4, 2, 1}, ; =1
;	 {5, 7, 4, 2, 1}, j =2
;	 {5, 4, 7, 2, 1}, j = 3
;	 {5, 4, 2, 7, 1}, j = 4
;	 {5, 4, 2, 1, 7}, j = 5
;     i=1 moves 5 to the highest possible rightmost position
;    {4, 5, 2, 1, 7}, ; =1
;	 {4, 2, 5, 1, 7}, j =2
;	 {4, 2, 1, 5, 7}, j = 3
;	 {4, 2, 1, 5, 7}, j = 4
;     i=2 moves 4 to the highest possible rightmost position
;    {2, 4, 1, 5, 7}, ; =1
;	 {2, 1, 4, 5, 7}, j =2
;	 {2, 1, 4, 5, 7}, j = 3
;     i=3 moves 2 to the highest possible rightmost position
;    {1, 2, 4, 5, 7}, ; =1
;	 {1, 2, 4, 5, 7}, j =2
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
; array BYTE 64h, 34h, 25h, 12h, 22h, 11h, 70h
		mov eax,edi  ;OK
		add eax,ebx ; eax has &arr[j] OK

		mov esi,eax ; OK
		inc esi     ; eax has &arr[j+1] OK
;		     [eax]         ecx
		;if (arr[j] > arr[j + 1])
		mov cl, [esi] ; ecx has arr[j + 1]
		cmp [eax],cl
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
	jb LOOP2
;step
inc ecx
COND1:
;condition
cmp ecx,edx
jb  LOOP1








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
 mov al,[esi+ecx]    ; arr[i] -> eax (indirect addressing)
 movsx eax,al
 call WriteHex
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

;    printf("Initial array: \n");
 mov edx, OFFSET message1
 call WriteString


 push ARRAYSIZE
 push OFFSET array
 call printarray
 add esp,8 ; mandatory for CDECL calling convention (2 arguments X 4 bytes = 8 bytes )
 call Crlf ; prints a newline to screen

 ;push OFFSET array+3
 ;push OFFSET array
 ;call swap
 ;add esp,8
 ;
 ;push ARRAYSIZE
 ;push OFFSET array
 ;call printarray
 ;add esp,8 ; mandatory for CDECL calling convention (2 arguments X 4 bytes = 8 bytes )
 ;call Crlf ; prints a newline to screen

;    bubbleSort(arr, n);
 push ARRAYSIZE
 push OFFSET array
 call bubblesort
 add esp,8 ; mandatory for CDECL calling convention (2 arguments X 4 bytes = 8 bytes )

 ;    printf("Sorted array: \n");
 mov edx, OFFSET message
 call WriteString


 push ARRAYSIZE
 push OFFSET array
 call printarray
 add esp,8 ; mandatory for CDECL calling convention (2 arguments X 4 bytes = 8 bytes )
 call Crlf ; prints a newline to screen




exit
main ENDP
END main
