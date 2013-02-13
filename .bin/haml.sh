#!/usr/bin/env bash

rm -R ./tpl/templates/
mkdir ./tpl/templates/
touch ./tpl/templates/.gitignore

cd ./haml/
for i in $( ls *.haml );
do
	echo ${i/.haml/}.haml
	haml -f html5 ${i/.haml/}.haml ../tpl/templates/${i/.haml/}.tpl
done
cd ../