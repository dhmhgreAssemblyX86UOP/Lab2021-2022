TITLE QuickSort Algorithm 
; https://www.geeksforgeeks.org/quick-sort/
Include Irvine32.inc




.data
array dword 1,2


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
;    int pivot = arr[high]; // pivot
;    int i = (low - 1); // Index of smaller element and indicates the right position of pivot found so far
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


main PROC


push OFFSET array +4
push OFFSET array 
call swap 

exit
main ENDP
END main