/*
피보나치 수열의 각 항은 바로 앞의 항 두 개를 더한 것이 됩니다. 1과 2로 시작하는 경우 이 수열은 아래와 같습니다.
1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...
짝수이면서 4백만 이하인 모든 항을 더하면 얼마가 됩니까?
*/

#include <cstdio>
#include <cassert>

const int MAX_RANGE = 4000000;

int calc(int max_range)
{
	int sum = 0;

	int prev_fibo = 1;
	int curr_fibo = 2;

	while(curr_fibo <= max_range) {
		if(curr_fibo % 2 == 0) {
			sum += curr_fibo;
		}
		int next_fibo = prev_fibo + curr_fibo;
		prev_fibo = curr_fibo;
		curr_fibo = next_fibo;
	}
	return sum;
}
int main()
{
	assert(calc(10) == 10);
	int sum = calc(MAX_RANGE);
	printf("%d\n", sum);
	return 0;
}
