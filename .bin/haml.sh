#!/usr/bin/env bash
for i in $( ls ./haml/*.haml );
do
	haml ${i/.haml/}.haml ./test/123
done
