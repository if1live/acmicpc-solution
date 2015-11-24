/*
세 자연수 a, b, c 가 피타고라스 정리 a2 + b2 = c2 를 만족하면 피타고라스 수라고 부릅니다
(여기서 a < b < c ).
예를 들면 32 + 42 = 9 + 16 = 25 = 52이므로 3, 4, 5는 피타고라스 수입니다.
a + b + c = 1000 인 피타고라스 수 a, b, c는 한 가지 뿐입니다. 이 때, a × b × c 는 얼마입니까?
*/

#include <cassert>
#include <cstdio>
#include <array>

const int MAX_RANGE = 1000;

int main()
{
	std::array<int, MAX_RANGE> square_list;
	for(int i = 0 ; i < MAX_RANGE ; ++i) {
		square_list[i] = i * i;
	}

	for(int c = MAX_RANGE - 1 ; c > 0 ; --c) {
		for(int b = MAX_RANGE - c - 1 ; b > 0 ; --b) {
			int a = MAX_RANGE - c - b;

			if(square_list[a] + square_list[b] == square_list[c]) {
				int retval = a * b * c;
				printf("%d %d %d => %d\n", a, b, c, retval);
				return retval;
			}
		}
	}

	return 0;
}
