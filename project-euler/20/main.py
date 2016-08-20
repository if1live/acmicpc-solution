#!/usr/bin/python3
#-*-coding: utf-8 -*-

'''
n! 이라는 표기법은 n × (n − 1) × ... × 3 × 2 × 1을 뜻합
예를 들자면 10! = 10 × 9 × ... × 3 × 2 × 1 = 3628800 이 되는데,
여기서 10!의 각 자리수를 더해 보면 3 + 6 + 2 + 8 + 8 + 0 + 0 = 27 입니다.

100! 의 자리수를 모두 더하면 얼마입니까?
'''

#100! 구하기
factorial = lambda x: (1 if x == 1 else x * factorial(x-1))
num = factorial(100)

sum = 0
while num > 0:
    sum = sum + num % 10
    num = num // 10
print(sum)
