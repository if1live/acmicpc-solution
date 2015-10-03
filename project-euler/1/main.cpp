/*
10보다 작은 자연수 중에서 3 또는 5의 배수는 3, 5, 6, 9 이고, 이것을 모두 더하면 23입니다.
1000보다 작은 자연수 중에서 3 또는 5의 배수를 모두 더하면 얼마일까요?
 */

#include <cstdio>
#include <cassert>

const int MAX_RANGE = 1000;

int main()
{
	// 10 => 3+6+9 = 3 * (1+2+3)
	int count_3 = (MAX_RANGE - 1) / 3;
	int count_5 = (MAX_RANGE - 1) / 5;
	int count_15 = (MAX_RANGE - 1) / 15;

	int sum = 0;
	sum += 3 * count_3 * (count_3 + 1) / 2;
	sum += 5 * count_5 * (count_5 + 1) / 2;
	sum -= 15 * count_15 * (count_15 + 1) / 2;
	printf("%d\n", sum);

	assert(sum == 233168);
	return 0;
}
