#!/bin/bash

function test_all {
	for problem in $(ls | grep "[[:digit:]]" | sort); do
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
	source=$(ls $problem/main.* 2> /dev/null)
	if [ $? != 0 ]; then
		printf "Problem #$problem's main source not exist\n"
		exit -1
	fi

	extension=$(ls $problem/main.* | cut -d. -f2)
	success=true

	if [ $use_diff = true ]; then
		echo "Problem #$problem [$extension]"
	fi

	# pre condition : compile
	if [ $extension = "cpp" ]; then
		clang++ -std=c++11 $source
	elif [ $extension = "c" ]; then
		clang $source
	elif [ $extension = "go" ]; then
		go build $source
	fi

	if [ $? != 0 ]; then
		printf "Compile Fail!\n"
		exit -1
	fi

	for input in $(ls $problem/input*); do
		run_single_test_case
		if [ $? != 0 ]; then success=false; fi
	done

	# post condition : delete compiled result
	if [ $extension = "cpp" ] || [ $extension = "c" ]; then
		rm -rf $problem/a.out
		rm -rf a.out
	elif [ $extension = "go" ]; then
		rm -rf $problem/main
		rm -rf main
	fi

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
		command="scm"
	elif [ $extension = "cpp" ] || [ $extension = "c" ]; then
		command="./a.out"
	elif [ $extension = "py" ]; then
		command="python3"
	elif [ $extension = "rb" ]; then
		command="ruby"
	elif [ $extension = "go" ]; then
		command="./main"
	else
		echo "Unknown extension : $extension"
		exit -1
	fi
	eval "$command $source < $input | tee $actual"

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

function show_source {
	source=$(ls $problem/main.* 2> /dev/null)
	if [ $? != 0 ]; then
		printf "Problem #$problem's main source not exist\n"
		exit -1
	fi
	cat $source
}

if [ "$#" -ne 2 ]; then
	echo "Commands"
	echo "$0 test all"
	echo "$0 test 1000"
	echo "$0 run 1000"
	echo "$0 show 1000"
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
elif [ $1 = "show" ]; then
	show_source
fi
