ACTUAL_RACKET	= actual-racket.txt
ACTUAL_SCM	= actual-scm.txt
INPUT	= input.txt
EXPECTED	= expected.txt
SOURCE	= main.rkt

all: test_racket test_scm clean

run_racket:
	racket -r $(SOURCE) < $(INPUT) > $(ACTUAL_RACKET)

test_racket: run_racket
	colordiff -w $(ACTUAL_RACKET) $(EXPECTED)

run_scm:
	scm $(SOURCE) < $(INPUT) > $(ACTUAL_SCM)

test_scm: run_scm
	colordiff -w $(ACTUAL_SCM) $(EXPECTED)

clean:
	rm -rf $(ACTUAL_SCM)
	rm -rf $(ACTUAL_RACKET)
