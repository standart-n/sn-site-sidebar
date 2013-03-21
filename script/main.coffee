	do (require) ->
		if typeof window != "undefined"
			jq = require "jquery"
			standart = require "sn"
			$ () ->
				$("#sn-side-menu").snSideBar()
