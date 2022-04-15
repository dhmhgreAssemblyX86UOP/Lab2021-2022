#include <stdio.h>
#include <stdlib.h>
#include <iostream>


void AddTwo(int a,int b, int *sum)
{
	int v[10] = { 1,2,3,4,5,6,7,8,9 };
	int i = 1;
	*sum = a + b + i;
	std::cout << sum;
	
}

void main()
{
	int sum = 0;
	int t = 5;
	AddTwo(t, 6, &sum);
	std::cout << sum;
}