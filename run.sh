#!/bin/bash

function test_all {
	for elem in $(ls $1 | sort); do
		test_problem $1/$elem
	done
}

function test_problem {
	run_problem_core $1 true
}

function run_problem {
	run_problem_core $1 false
}

function run_problem_core {
	problem=$1
	use_diff=$2

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

	ls $problem/input* 1> /dev/null 2> /dev/null
	if [ $? = 0 ]; then
		input_exist=true
	else
		input_exist=false
	fi

	if [ $input_exist = true ]; then
		for input in $(ls $problem/input*); do
			run_single_test_case
			if [ $? != 0 ]; then success=false; fi
		done
	else
		simple_run
	fi

	# post condition : delete compiled result
	if [ $extension = "cpp" ] || [ $extension = "c" ]; then
		rm -rf $problem/a.out
		rm -rf a.out
	elif [ $extension = "go" ]; then
		rm -rf $problem/main
		rm -rf main
	fi

	if [ $use_diff = true ] && [ $input_exist = true ]; then
		if [ $success = true ]; then
			printf "\nSolved!\n\n"
		else
			printf "\nFail!\n\n"
		fi
	fi
}

function select_runner {
	if [ $1 = "rkt" ] || [ $1 = "scm" ]; then
		runner="scm"
	elif [ $1 = "cpp" ] || [ $1 = "c" ]; then
		runner="./a.out"
	elif [ $1 = "py" ]; then
		runner="python3"
	elif [ $1 = "rb" ]; then
		runner="ruby"
	elif [ $1 = "go" ]; then
		runner="./main"
	else
		echo "Unknown extension : $extension"
		exit -1
	fi
}

function simple_run {
	select_runner $extension
	eval "time $runner"
	return 0
}

function run_single_test_case {
	# input-abc.txt -> abc
	num=$(echo $input | cut -d. -f1 | cut -d- -f2)
	expected="$problem/expected-$num.txt"
	actual="actual.txt"
	success=true
	select_runner $extension
	eval "$runner $source < $input | tee $actual"

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
	source=$(ls $1/main.* 2> /dev/null)
	if [ $? != 0 ]; then
		printf "Problem #$problem's main source not exist\n"
		exit -1
	fi
	cat $source
}

if [ "$#" -ne 2 ]; then
	echo "Commands"
	echo "$0 test acmicpc"
	echo "$0 test acmicpc/1000"
	echo "$0 run acmicpc/1000"
	echo "$0 show acmicpc/1000"
	exit -1
fi

command=$1
problem=$2
echo $problem | grep "/" > /dev/null
if [ $? = 0 ]; then
	category=$(echo $problem | cut -d/ -f1)
	problem_name=$(echo $problem | cut -d/ -f2)
else
	category=$(echo $problem | cut -d/ -f1)
	problem_name=""
fi

function display_args {
    printf "Command: $command\n"
    printf "Category: $category\n"
    printf "Problem: $problem_name\n"
    printf "\n"
}
#display_args

if [ $command = "test" ]; then
	if [ -z $problem_name ]; then
		test_all $problem
	else
		test_problem $problem
	fi
elif [ $command = "run" ]; then
	run_problem $problem
elif [ $command = "show" ]; then
	show_source $problem
fi
