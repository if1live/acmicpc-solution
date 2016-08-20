#!/usr/bin/python3

'''
2**15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.
What is the sum of the digits of the number 2**1000?

2**15 = 32768 의 각 자리수를 더하면 3 + 2 + 7 + 6 + 8 = 26 입니다.
2**1000의 각 자리수를 모두 더하면 얼마입니까?
'''

num = 2 ** 1000
sum = 0
while num > 0:
    sum = sum + num % 10
    num = num // 10
print(sum)
