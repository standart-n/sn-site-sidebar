$ () ->
	methods = 
		init: (options = {}) ->
			def =
				top: 30
				width: 200
				contentWidth: 900

			$.extend true, def, options

			if $(document).width() > (def.contentWidth+(def.width*2))

				$('a.dropdown').live "click", (e) ->
					if !$(this).hasClass('go')
						e.preventDefault()
						if $(this).hasClass('active')
							$(this).removeClass('active').parent('li').children('ul.sub').hide()
						else
							$('ul.sub').hide()
							$('a.dropdown').removeClass('active')
							$(this).parent('li').children('ul.sub').show()
							$(this).addClass('active')

				$('a.active').each () ->
					$(this).parent('li').children('ul.sub').show()

				$('a.dropdown').each () ->
					reg = $(this).attr('href')
					if window.location.href.match(reg)
						$(this).addClass('active').parent('li').children('ul.sub').show()

				$(this).css
					top: def.top+'px'
					marginLeft: ((def.contentWidth/2)+def.width)*(-1)+'px'

				$(this).css
					display: 'block'

				# alert ((def.contentWidth/2)+def.width)*(-1)+'px'
			
			else

				$(this).css
					display: 'none'			

	$.fn.snSideBar = (sn = {}) ->
		if methods[sn] 
			methods[sn].apply @, Array.prototype.slice.call arguments, 1
		else 
			if typeof sn == 'object' || !sn
				methods.init.apply @,arguments
			else 
				$.error 'Метод ' + sn + ' не существует'


