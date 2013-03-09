
exports.parseMessages = (data) ->
	parser = global.controls.lib.parser.init()
	s = data.toString()
	s = s.replace(/[\s\S]*?IN-BOX/igm,'')
	s = s.replace(/----------------------------------------------------------------------------------/gm,'')
	# s = s.replace(/(Sun|Mon|Tue|Wed|Thu|Fri|Sat|Sun)(\s){1,3}(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)(\s){1,3}(\d){1,2}(\s){1,2}([01]\d|2[0-3])(:[0-5]\d){2}(\s){1,3}((19|20)\d\d)/gm,'!!!')
	s = s.replace(/(.*?)# exit/g,'')
	s = s.replace(/(.*?)> exit/g,'')
	parser.parse s
	
exports.snParseMessages = (data) ->
	sanitize = global.controls.lib.validator.sanitize()
	ms = []
	s = data.toString()
	s = s.replace(/[\s\S]*?IN-BOX/igm,'')
	s = s.replace(/(.*?)Index SimIndex     PhoneNumber                      Date  Message(.*?)/gm,'')
	s = s.replace(/----------------------------------------------------------------------------------/gm,'')
	s = s.replace(/(.*?)# exit/g,'')
	s = s.replace(/(.*?)> exit/g,'')
	lines = s.match(/^([\ 0-9]{5}[\ 0-9]{9}[\ 0-9a-zA-Z\.\+\:]{16}[\ 0-9a-zA-Z\.\+\:]{26} .*?)$/gim)
	if lines
		lines.filter (value, i) ->
			ms[i] = {}
			ms[i].id = sanitize(value.replace(/^([\ 0-9]{5})([\ 0-9]{9})([\ 0-9a-zA-Z\.\+\:]{16})([\ 0-9a-zA-Z\.\+\:]{26}) (.*?)$/i,'$1')).trim()
			ms[i].sim = sanitize(value.replace(/^([\ 0-9]{5})([\ 0-9]{9})([\ 0-9a-zA-Z\.\+\:]{16})([\ 0-9a-zA-Z\.\+\:]{26}) (.*?)$/i,'$2')).trim()
			ms[i].phone = sanitize(value.replace(/^([\ 0-9]{5})([\ 0-9]{9})([\ 0-9a-zA-Z\.\+\:]{16})([\ 0-9a-zA-Z\.\+\:]{26}) (.*?)$/i,'$3')).trim()
			ms[i].text = sanitize(value.replace(/^([\ 0-9]{5})([\ 0-9]{9})([\ 0-9a-zA-Z\.\+\:]{16})([\ 0-9a-zA-Z\.\+\:]{26}) (.*?)$/i,'$5')).trim()
			date = sanitize(value.replace(/^([\ 0-9]{5})([\ 0-9]{9})([\ 0-9a-zA-Z\.\+\:]{16})([\ 0-9a-zA-Z\.\+\:]{26}) (.*?)$/i,'$4')).trim()
			ms[i].date = global.controls.parser.parseMessageDate date
			# console.log value
	ms

exports.parseMessageDate = (s) ->
	ms =  {}	
	ms.D = s.replace(/(Sun|Mon|Tue|Wed|Thu|Fri|Sat|Sun)\s{1,3}(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\s{1,3}(\d){1,2}\s{1,2}([0-1][0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9])\s{1,3}((19|20)\d\d)/gm,'$1')
	ms.M = s.replace(/(Sun|Mon|Tue|Wed|Thu|Fri|Sat|Sun)\s{1,3}(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\s{1,3}(\d){1,2}\s{1,2}([0-1][0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9])\s{1,3}((19|20)\d\d)/gm,'$2')
	ms.j = s.replace(/(Sun|Mon|Tue|Wed|Thu|Fri|Sat|Sun)\s{1,3}(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\s{1,3}(\d){1,2}\s{1,2}([0-1][0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9])\s{1,3}((19|20)\d\d)/gm,'$3')
	ms.H = s.replace(/(Sun|Mon|Tue|Wed|Thu|Fri|Sat|Sun)\s{1,3}(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\s{1,3}(\d){1,2}\s{1,2}([0-1][0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9])\s{1,3}((19|20)\d\d)/gm,'$4')
	ms.i = s.replace(/(Sun|Mon|Tue|Wed|Thu|Fri|Sat|Sun)\s{1,3}(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\s{1,3}(\d){1,2}\s{1,2}([0-1][0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9])\s{1,3}((19|20)\d\d)/gm,'$5')
	ms.s = s.replace(/(Sun|Mon|Tue|Wed|Thu|Fri|Sat|Sun)\s{1,3}(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\s{1,3}(\d){1,2}\s{1,2}([0-1][0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9])\s{1,3}((19|20)\d\d)/gm,'$6')
	ms.Y = s.replace(/(Sun|Mon|Tue|Wed|Thu|Fri|Sat|Sun)\s{1,3}(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\s{1,3}(\d){1,2}\s{1,2}([0-1][0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9])\s{1,3}((19|20)\d\d)/gm,'$7')
	['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'].filter (value,i) ->
		ms.n = i if value == ms.M
	if ms.n < 10 then ms.m = '0' + ms.n.toString() else ms.m = ms.n
	if ms.j < 10 then ms.d = '0' + ms.j.toString() else ms.d = ms.j
	ms.date = ms.d + '.' + ms.m + '.' + ms.Y
	ms.time = ms.H + ':' + ms.i + ':' + ms.s
	ms.datetime = ms.date+' '+ms.time
	ms


		# console.log 'data'
		#  s = data.toString().replace(/[\s\S]*?IN-BOX/igm,'')
		#  s = s.replace(/----------------------------------------------------------------------------------/gm,'')
		# s = s.replace(/(.*?)Index SimIndex     PhoneNumber                      Date  Message(.*?)/gm,'')
		#  s = s.replace(/(Sun|Mon|Tue|Wed|Thu|Fri|Sat|Sun)(\s){1,3}(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)(\s){1,3}(\d){1,2}(\s){1,2}([01]\d|2[0-3])(:[0-5]\d){2}(\s){1,3}((19|20)\d\d)/gm,'!!!')
		#  s = s.replace(/(.*?)# exit/g,'')
		#  s = s.replace(/(.*?)> exit/g,'')
		# console.log 'data:', s
		# console.log 'parser:', parser.parse s
