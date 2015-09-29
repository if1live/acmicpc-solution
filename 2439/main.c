#include <stdio.h>

void print_line(int space, int star)
{
	for(int i = 0 ; i < space ; ++i) {
		printf(" ");
	}
	for(int i = 0 ; i < star ; ++i) {
		printf("*");
	}
	printf("\n");
}

int main()
{
	int count = 0;
	scanf("%d", &count);

	for(int i = 1, j = count - 1 ; i <= count ; ++i, j--) {
		print_line(j, i);
	}
	return 0;
}
