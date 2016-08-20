#!/usr/bin/python3
#-*-coding: utf-8 -*-

'''
대칭수(palindrome)인 585는 2진수로 나타내도 1001001001(2)가 되어 여전히 대칭수입니다.
10진법과 2진법으로 모두 대칭수인 1,000,000 이하 숫자의 합을 구하세요.
(주의: 첫번째 자리가 0이면 대칭수가 아님)
'''
MAX = 1000000

def isPalindromic10(num):
    #기본 문자열
    s1 = str(num)

    #뒤집은 문자열 구하기
    l = list(s1)
    l.reverse()
    s2 = ''.join(l)
    if s1 == s2:
        return True
    else:
        return False

def isPalindromic2(num):
    #2진수로 변환하기
    s = []
    while num > 0:
        s.append(str(num % 2))
        num = num // 2
    #뒤집어진 2진수를 구하기
    s2 = ''.join(s)

    #정상적인 2진수 구하기
    s.reverse()
    s1 = ''.join(s)
    if s1 == s2:
        return True
    else:
        return False

sum = 0
for x in range(1, 1+MAX):
    if isPalindromic10(x) == True:
        if isPalindromic2(x) == True:
            sum = sum + x
print(sum)
