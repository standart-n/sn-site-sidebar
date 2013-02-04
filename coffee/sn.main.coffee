main (require) ->
	if typeof window != "undefined"
		jq=require 'jquery'
		standart=require 'sn'
		bs=require 'bootstrap'
		$ ->
			$('#sn').sn()