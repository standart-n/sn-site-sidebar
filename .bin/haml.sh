#!/usr/bin/env bash
cd ./haml/
for i in $( ls *.haml );
do
	haml ${i/.haml/}.haml ../tpl/templates/${i/.haml/}.tpl
	#echo ${i/.haml/}.haml
done
cd ../
