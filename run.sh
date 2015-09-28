#!/bin/bash

for problem in $(ls | grep "[[:digit:]]")
do
	echo "Problem #$problem"
	cd $problem ; make ; cd -
	echo ""
done
