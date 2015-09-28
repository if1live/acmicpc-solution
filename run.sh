#!/bin/bash

function test_all {
	for problem in $(ls | grep "[[:digit:]]"); do
		test_problem
	done
}

function test_problem {
	ACTUAL_RACKET="$problem/actual-racket.txt"
	ACTUAL_SCM="$problem/actual-scm.txt"
	INPUT="$problem/input.txt"
	EXPECTED="$problem/expected.txt"
	SOURCE="$problem/main.rkt"
	SUCCESS=true

	echo "Problem #$problem"

	racket -r $SOURCE < $INPUT > $ACTUAL_RACKET
	colordiff -w $ACTUAL_RACKET $EXPECTED
	if [[ $? != "0" ]]; then SUCCESS=false; fi

	scm $SOURCE < $INPUT > $ACTUAL_SCM
	colordiff -w $ACTUAL_SCM $EXPECTED
	if [[ $? != "0" ]]; then SUCCESS=false; fi

	rm -rf $ACTUAL_SCM
	rm -rf $ACTUAL_RACKET

	if [ $SUCCESS = true ]; then echo "Solved!"; fi
}

function run_racket {
	ACTUAL_RACKET="$problem/actual-racket.txt"
	INPUT="$problem/input.txt"
	SOURCE="$problem/main.rkt"
	racket -r $SOURCE < $INPUT
}

function run_scm {
	ACTUAL_SCM="$problem/actual-scm.txt"
	INPUT="$problem/input.txt"
	SOURCE="$problem/main.rkt"
	scm $SOURCE < $INPUT
}

if [ "$#" -ne 2 ]; then
	echo "Commands"
	echo "$0 test all"
	echo "$0 test 1000"
	echo "$0 run_racket 1000"
	echo "$0 run_scm 1000"
	exit -1
fi

problem=$2

if [ $1 = "test" ]; then
	if [ $2 = "all" ]; then
		test_all
	else
		test_problem
	fi
elif [ $1 = "run_racket" ]; then
	run_racket
elif [ $1 = "run_scm" ]; then
	run_scm
fi
