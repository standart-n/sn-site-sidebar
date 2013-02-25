
DATE=$(shell date +%I:%M%p)
CHECK=\033[32m✔\033[39m
HR=\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#


#
# BUILD DOCS
#

all: start client finish

client: coffee-js js css img jade-tpl ajaxloader

sn: sn-css main-css coffee-js sn-js lmd

bs: bs-css main-css bs-js bs-img lmd

js: coffee-js sn-js bs-js lmd

css: sn-css bs-css main-css

img: bs-img

check-js:
	@echo "\nrunning JSHint on javascript...\n"
	@mkdir -p ./js-tmp/
	@cp ./js/client/sn.js ./js-tmp/sn.js
	@cp ./js/client/main.js ./js-tmp/main.js
	@jshint ./js-tmp/*.js --config ./.jshintrc
	@rm -R ./js-tmp/

	@echo "\nbs: running JSHint on javascript...\n"
	@jshint ./bootstrap/js/*.js --config ./bootstrap/js/.jshintrc

ajaxloader:
	@echo "\najaxloader...\n"
	@cat ./tpl/templates/index.html > ./index.html

lmd:
	@echo "\nlmd...\n"
	@lmd build dev

jade-tpl:
	@echo "\njade...\n"
	@rm -R ./tpl/templates/
	@mkdir ./tpl/templates/
	@touch ./tpl/templates/.gitignore
	@jade --pretty ./jade/ -O ./tpl/templates

coffee-js:
	@echo "\ncoffee...\n"
	@coffee -cbjvp ./script/ > ./js/client/sn.js

main-css:
	@cat ./css/bootstrap.css ./css/bootstrap-responsive.css ./css/sn.css > ./css/style.css
	@cat ./css/bootstrap.min.css ./css/bootstrap-responsive.min.css ./css/sn.min.css > ./css/style.min.css

sn-css:
	@echo "\nsn: compiling LESS with Recess\n"
	@recess --compile ./less/sn.less > ./css/sn.css
	@recess --compress ./less/sn.less > ./css/sn.min.css

sn-js:
	@echo "\nsn: compiling and minifying javascript...\n"
	@cp ./main.js ./js/client/main.js

	@echo "\nsn: uglifyjs...\n"
	@uglifyjs ./js/client/sn.js -nc > ./js/client/sn.min.js
	@uglifyjs ./js/client/main.js -nc > ./js/client/main.min.js

bs-img:
	@cp ./bootstrap/img/* ./img/

bs-css:
	@echo "\nbs: compiling LESS with Recess...\n"
	@recess --compile ./bootstrap/less/bootstrap.less > ./css/bootstrap.css
	@recess --compress ./bootstrap/less/bootstrap.less > ./css/bootstrap.min.css
	@recess --compile ./bootstrap/less/responsive.less > ./css/bootstrap-responsive.css
	@recess --compress ./bootstrap/less/responsive.less > ./css/bootstrap-responsive.min.css

bs-js:
	@echo "bs: compiling and minifying javascript...\n"
	@cat ./bootstrap/js/bootstrap-*.js  > ./js/client/bootstrap.js
	@uglifyjs ./js/client/bootstrap.js -nc > ./js/client/bootstrap.min.tmp.js

	@echo "/**\n* bootstrap.js v2.2.2 by @fat & @mdo\n* Copyright 2012 Twitter, Inc.\n* http://www.apache.org/licenses/LICENSE-2.0.txt\n*/" > ./bootstrap/copyright
	@cat ./bootstrap/copyright ./js/client/bootstrap.min.tmp.js > ./js/client/bootstrap.min.js
	@rm ./bootstrap/copyright ./js/client/bootstrap.min.tmp.js

start:
	@echo "standart-n: \n"
	@mkdir -p ./js/
	@rm -R ./js/
	@mkdir ./js/
	@touch ./js/.gitignore
	@mkdir -p ./js/client/
	@chmod 777 -R ./js/

finish:
	@echo "\nSuccessfully built at ${DATE}."


#	@echo "${HR}\n"
#	@echo "Thanks for using Bootstrap,"

#
# RUN JSHINT & QUNIT TESTS IN PHANTOMJS
#


#.PHONY: docs watch gh-pages
