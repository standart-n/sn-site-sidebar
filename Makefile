
BS = bootstrap
DATE=$(shell date +%I:%M%p)
CHECK=\033[32m✔\033[39m
HR=\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#


#
# BUILD DOCS
#

all: start caffeine js css img haml-tpl finish

sn: sn-css caffeine sn-js lmd

bs: bs-css bs-js bs-img lmd

js: caffeine sn-js bs-js lmd

css: sn-css bs-css main-css

img: bs-img

lmd:
	@echo "lmd\n"
	@lmd build dev

haml-tpl:
	@echo "haml...\n"
	@./.bin/haml.sh

caffeine:
	@echo "coffee...\n"
	@coffee -o ./script/ -cb ./coffee/*.coffee

main-css:
	@cat ./css/bootstrap.css ./css/bootstrap-responsive.css ./css/sn.css > ./css/style.css

sn-css:
	@echo "sn: compiling LESS with Recess\n"
	@recess --compile ./less/sn.less > ./css/sn.css

sn-js:
	@echo "sn: compiling and minifying javascript...\n"
	@cat ./script/sn.js ./script/sn.ajax.js ./script/sn.conf.js ./script/sn.events.js ./script/sn.triggers.js > ./js/sn.js
	@cp ./.lmd/main ./script/sn.main.js
	@cp ./script/sn.main.js ./js/sn.main.js

	@echo "sn: running JSHint on javascript...\n"
	@jshint ./script/*.js --config ./script/.jshintrc

	@echo "sn: uglifyjs...\n"
	@uglifyjs ./js/sn.js -nc > ./js/sn.min.js
	@uglifyjs ./js/sn.main.js -nc > ./js/sn.main.min.js

bs-img:
	@cp ./${BS}/img/* ./img/

bs-css:
	@echo "bs: compiling LESS with Recess...\n"
	@recess --compile ./${BS}/less/bootstrap.less > ./css/bootstrap.css
	@recess --compile ./${BS}/less/responsive.less > ./css/bootstrap-responsive.css

bs-js:
	@echo "bs: running JSHint on javascript...\n"
	@jshint ./${BS}/js/*.js --config ./${BS}/js/.jshintrc
	
	@echo "bs: compiling and minifying javascript...\n"
	@cat ./${BS}/js/${BS}-transition.js ./${BS}/js/${BS}-alert.js ./${BS}/js/${BS}-button.js ./${BS}/js/${BS}-carousel.js ./${BS}/js/${BS}-collapse.js ./${BS}/js/${BS}-dropdown.js ./${BS}/js/${BS}-modal.js ./${BS}/js/${BS}-tooltip.js ./${BS}/js/${BS}-popover.js ./${BS}/js/${BS}-scrollspy.js ./${BS}/js/${BS}-tab.js ./${BS}/js/${BS}-typeahead.js ./${BS}/js/${BS}-affix.js > ./js/bootstrap.js
	@uglifyjs ./js/bootstrap.js -nc > ./js/bootstrap.min.tmp.js

	@echo "/**\n* ${BS}.js v2.2.2 by @fat & @mdo\n* Copyright 2012 Twitter, Inc.\n* http://www.apache.org/licenses/LICENSE-2.0.txt\n*/" > ./${BS}/copyright
	@cat ./${BS}/copyright ./js/${BS}.min.tmp.js > ./js/${BS}.min.js
	@rm ./${BS}/copyright ./js/${BS}.min.tmp.js

start:
	@echo "standart-n: \n"

finish:
	@echo "Successfully built at ${DATE}."


#	@echo "${HR}\n"
#	@echo "Thanks for using Bootstrap,"
#	@cp ./script/sn.main.js ./js/sn.main.js

#
# RUN JSHINT & QUNIT TESTS IN PHANTOMJS
#

# haml ./haml/* ./test/

#.PHONY: docs watch gh-pages
