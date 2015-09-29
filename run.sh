#!/bin/bash

function test_all {
	for problem in $(ls | grep "[[:digit:]]"); do
		test_problem
	done
}

function test_problem {
	use_diff=true
	run_problem_core
}

function run_problem {
	use_diff=false
	run_problem_core
}

function run_problem_core {
	source=$(ls $problem/main.*)
	extension=$(ls $problem/main.* | cut -d. -f2)
	success=true

	if [ $use_diff = true ]; then
		echo "Problem #$problem [$extension]"
	fi

	# pre condition
	if [ $extension = "cpp" ]; then
		clang $source
	fi

	for input in $(ls $problem/input*); do
		run_single_test_case
		if [ $? != 0 ]; then success=false; fi
	done

	if [ $use_diff = true ]; then
		if [ $success = true ]; then
			printf "\nSolved!\n\n"
		else
			printf "\nFail!\n\n"
		fi
	fi
}

function run_single_test_case {
	# input-abc.txt -> abc
	num=$(echo $input | cut -d. -f1 | cut -d- -f2)
	expected="$problem/expected-$num.txt"
	actual="actual.txt"
	success=true

	if [ $extension = "rkt" ] || [ $extension = "scm" ]; then
		scm $source < $input | tee $actual
	elif [ $extension = "cpp" ]; then
		./a.out < $input | tee $actual
	fi

	if [ $use_diff = true ]; then
		colordiff -w $expected $actual
		if [[ $? != "0" ]]; then success=false; fi
	fi

	rm -rf $actual

	if [ $success = true ]; then
		return 0
	else
		return -1
	fi
}

if [ "$#" -ne 2 ]; then
	echo "Commands"
	echo "$0 test all"
	echo "$0 test 1000"
	echo "$0 run 1000"
	exit -1
fi

problem=$2

if [ $1 = "test" ]; then
	if [ $2 = "all" ]; then
		test_all
	else
		test_problem
	fi
elif [ $1 = "run" ]; then
	run_problem
fi
