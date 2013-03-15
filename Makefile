
TPL=smarty
DATE=$(shell date +%I:%M%p)
CHECK=\033[32m✔\033[39m
HR=\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#


#
# BUILD DOCS
#

def: all

all: folders client finish

client: coffee-js js css indexhtml

js: coffee-js sn-js lmd

css: sn-css main-css



indexhtml:
	@echo "\nindexhtml...\n"
	@jade --pretty ./layout/${TPL}/index.jade -O ./

lmd:
	@echo "\nlmd...\n"
	@lmd build dev

coffee-js:
	@echo "\ncoffee...\n"
	@coffee -cbjvp ./client/sn*.coffee > ./public/js/client/sn.js

main-css:
	@cat ./public/css/sn.css > ./public/css/style.css
	@cat ./public/css/sn.min.css > ./public/css/style.min.css

sn-css:
	@echo "\nsn: compiling LESS with Recess\n"
	@recess --compile ./less/sn.less > ./public/css/sn.css
	@recess --compress ./less/sn.less > ./public/css/sn.min.css

sn-js:
	@echo "\nsn: compiling and minifying javascript...\n"
	@coffee -cbjvp ./script/main*.coffee > ./public/js/client/main.js

	@echo "\nsn: uglifyjs...\n"
	@uglifyjs ./public/js/client/sn.js -nc > ./public/js/client/sn.min.js
	@uglifyjs ./public/js/client/main.js -nc > ./public/js/client/main.min.js




folders:
	@mkdir -p ./public/img
	@mkdir -p ./public/css
	@mkdir -p ./public/materials
	@mkdir -p ./public/files
	@mkdir -p ./public/js/client
	@mkdir -p ./public/js/controls
	@mkdir -p ./public/js/routes
	@mkdir -p ./public/js/tpl
	
finish:
	@echo "\nSuccessfully built at ${DATE}."

#
# RUN JSHINT & QUNIT TESTS IN PHANTOMJS
#

#.PHONY: docs watch gh-pages
