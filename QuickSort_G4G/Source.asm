TITLE QuickSort Algorithm 
; https://www.geeksforgeeks.org/quick-sort/
Include Irvine32.inc




.data
array dword 10, 7, 8, 9, 1, 5
ARRAYSIZEM1 = ($-array)/TYPE array -1
message BYTE "Sorted Array :",0
message1 BYTE "Initial Array :",0
keno BYTE " ",0 
.code

;#include <bits/stdc++.h>
;using namespace std;
 
;// A utility function to swap two elements
;void swap(int* a, int* b)
;{
; argument a : ebp + 8
; argument b : ebp +12
;    int t = *a;
;    *a = *b;
;    *b = t;
;}
; 
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
ret 8
swap ENDP



;/* This function takes last element as pivot, places
;the pivot element at its correct position in sorted
;array, and places all smaller (smaller than pivot)
;to left of pivot and all greater elements to right
;of pivot */
;int partition (int arr[], int low, int high)
;{
; arr : EBP+8
; low : EBP+12
; high : EBP+16
;    int pivot = arr[high]; // pivot EBP-4
;    int i = (low - 1); // EBP-8 Index of smaller element and indicates the right position of pivot found so far
; 
;    for (int j = low; j <= high - 1; j++)
;    {
;        // If current element is smaller than the pivot
;        if (arr[j] < pivot)
;        {
;            i++; // increment index of smaller element
;            swap(&arr[i], &arr[j]);
;       }
;    }
;    swap(&arr[i + 1], &arr[high]);
;    return (i + 1);
;}
partition PROC
;prologue
push ebp
mov ebp,esp
sub esp,8
push ebx
push ecx
push edx
push esi
push edi

;body

;int pivot = arr[high]; // pivot
mov esi, [EBP+8] ;esi points to the arr[]
mov ebx, [EBP+16] ; ebx has high
mov eax, [esi+ebx*4] ; eax has arr[high]

lea edi, [EBP-4] ; edi has the address of pivot
mov [edi],eax ; transfer arr[high] to pivot
mov ecx, eax ; ecx has pivot

;int i = (low - 1);
mov eax,[ebp+12] ;  eax has low
dec eax ; eax has low - 1

lea edi, [EBP-8] ; edi has the address of i
mov [edi],eax ; transfer low-1 to i
mov edx,eax ; edx works as the i variable

; We select esi as the loop iterator
;1:Initialization
mov esi,[ebp+12] ; Initialize esi with low
jmp COND
LOOP1:
   ;2: body
;   // If current element is smaller than the pivot
;        if (arr[j] < pivot (ecx))
;        {
;            i++; // increment index of smaller element
;            swap(&arr[i], &arr[j]);
;       }
	
	mov edi, [EBP+8] ;edi points to the arr[]
	mov eax, [edi+esi*4] ; eax has arr[j]
;if condition	
	cmp eax,ecx
	jge STEP
;if true path
	inc edx


	lea ebx,[edi+esi*4]
	push ebx
	lea ebx,[edi+edx*4]
	push ebx
	call swap

;if false path

STEP:
   ;3: step
   inc esi ; increase loop iterator esi

COND:
   ; 4: condition
   mov eax, [ebp+16] ; move high to eax
   dec eax ; eax has high -1
   cmp esi,eax
   jle LOOP1

   ;    swap(&arr[i + 1], &arr[high]);
   mov ecx,[ebp+16]
   lea ebx, [edi+ecx*4]
   push ebx
   lea ebx , [edi+esi*4]
   push ebx
   call swap

   ;    return (i + 1);
   mov eax,esi

;epilogue
pop edi
pop esi
pop edx
pop ecx
pop ebx
mov esp,ebp
pop ebp
ret 12
partition ENDP






 

; 
;/* The main function that implements QuickSort
;arr[] --> Array to be sorted,
;low --> Starting index,
;high --> Ending index */
;void quickSort(int arr[], int low, int high)
;{
;   if (low < high)
;    {
;        /* pi is partitioning index, arr[p] is now
;        at right place */
;        int pi = partition(arr, low, high);
; 
;        // Separately sort elements before
;        // partition and after partition
;        quickSort(arr, low, pi - 1);
;        quickSort(arr, pi + 1, high);
;    }
;}
quicksort PROC
;prologue
push ebp
mov ebp,esp
pushad

;body

	mov eax,[ebp+12]
	cmp eax,[ebp+16]
	jge FALSEBODY
TRUEBODY:

	push [ebp+16]
	push [ebp+12]
	push [ebp+8]
	call partition
	; eax has the result of partition

	mov ebx,eax
	dec ebx
	push ebx
	push [ebp+12]
	push [ebp+8]
	call quicksort

	push [ebp+16]
	mov ebx,eax
	inc ebx
	push ebx
	push [ebp+8]
	call quicksort


	
FALSEBODY:
;epilogue
popad
mov esp,ebp
pop ebp
ret 12
quicksort ENDP



; 
;/* Function to print an array */
;void printArray(int arr[], int size)
;{
;    int i;
;    for (i = 0; i < size; i++)
;        cout << arr[i] << " ";
;    cout << endl;
;}
; 
;// Driver Code
;int main()
;{
;    int arr[] = {10, 7, 8, 9, 1, 5};
;    int n = sizeof(arr) / sizeof(arr[0]);
;    quickSort(arr, 0, n - 1);
;    cout << "Sorted array: \n";
;    printArray(arr, n);
;    return 0;
;}


;/* Function to print an array */
;void printArray(int arr[], int size)
;{
;    int i;
;    for (i = 0; i < size; i++)
;        cout << arr[i] << " ";
;    cout << endl;
;}
PrintArray PROC
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
ret 8
PrintArray ENDP

main PROC

mov edx, OFFSET message1  
call WriteString   ; Initial Array :
push ARRAYSIZEM1
push OFFSET array
call PrintArray
call CrLf


push ARRAYSIZEM1
push 0
push OFFSET array
call quicksort

mov edx, OFFSET message  
call WriteString   ; Sorted Array :
push ARRAYSIZEM1
push OFFSET array
call PrintArray


exit
main ENDP
END main