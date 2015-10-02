/*
10보다 작은 자연수 중에서 3 또는 5의 배수는 3, 5, 6, 9 이고, 이것을 모두 더하면 23입니다.
1000보다 작은 자연수 중에서 3 또는 5의 배수를 모두 더하면 얼마일까요?
 */

#include <cstdio>

int main()
{
    const int MAX_RANGE = 1000;
    int sum = 0;
    for(int i = 0 ; i < MAX_RANGE ; ++i) {
        bool is_mul_3 = (i % 3 == 0);
        bool is_mul_5 = (i % 5 == 0);
        if(is_mul_3 || is_mul_5) {
            sum += i;
        }
    }
    printf("%d\n", sum);
    return 0;
}
