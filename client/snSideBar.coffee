$ ->
	methods= 
		init:(options) ->
			options={} if !options
			def=
				top: '100px'
				left: '-300px'
				maxWidth: '1200px'

			$.extend true,def,options

			$(this).css
				'top':def.top
				'margin-left':def.left

			$("a.dropdown").on "click", (e) ->
				e.preventDefault()
				if $(this).hasClass('active')
					$(this).parent('li').children('ul.sub').hide()
					$(this).removeClass('active')
				else
					$('ul.sub').hide()
					$('a.dropdown').removeClass('active')
					$(this).parent('li').children('ul.sub').show()
					$(this).addClass('active')





	$.fn.snSideBar= (sn) ->
		sn={} if !sn
		if methods[sn] 
			methods[sn].apply @,Array.prototype.slice.call arguments,1
		else 
			if typeof sn=='object' || !sn
				methods.init.apply @,arguments
			else 
				$.error 'Метод '+sn+' не существует'