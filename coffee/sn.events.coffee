$ ->
	methods=
		init:(options) ->
			@each ->
				def=
					href:'none'
				$.extend true,def,options
				sn=$(@).data 'sn'
				href=def.href
				switch href.replace "/(.*)#(.*)/","$2"
					when "autoload" then
					when "signin"
						$("#signin-error").hide()
						$(@).snAjax 'sendRequest',(action:'signin',debug:false)
					when "afterSignin"
						if sn.result
							if sn.result.response
								if sn.result.claims
									$('#claims').html sn.result.claims
									$(@).snTriggers 'table'
								if sn.result.pagination
									$("#pagination").html sn.result.pagination
									$(@).snTriggers pagination
								$("#signin").empty()
							else
								$("#inputLogin").val ''
								$("#inputPassword").val ''
								$("#signin-error").show()
					when "submit"
						$(@).snAjax 'sendRequest',(action:'submit',debug:false)
					when "afterSubmit"
						if sn.result
							if sn.result.table
								$("#table").html sn.result.table
								$(@).snTriggers 'sort'
								$(@).snTriggers 'detail'
								$(@).snPlayer 'onClickPlay'
					when "close" then $(@).hide()


	$.fn.snEvents= (sn) ->
		sn={} if !sn
		if methods[sn]
			methods[sn].apply @,Array.prototype.slice.call arguments,1
		else 
			if typeof sn=='object' || !sn
				methods.init.apply @,arguments
			else 
				$.error 'Метод '+sn+' не существует'


