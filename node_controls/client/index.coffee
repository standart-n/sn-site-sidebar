
exports.connect = (cn, callback) ->
	global.clientAnswer = ''
	net = global.controls.lib.net.init()
	client = net.connect cn.connect.port, cn.connect.ip
	callback client

exports.getAllMessages = (client, cn, callback) ->
	colors = global.controls.lib.colors.init()
	
	client.write cn.connect.login + '\n'
	client.write cn.connect.password + '\n'
	client.write 'en' + '\n'
	client.write cn.commands.getAllMessages.cmd + '\n'
	client.write 'exit' + '\n'
	client.write 'exit' + '\n'

	client.on 'data', (data) ->
		global.clientAnswer += data.toString()

	client.on 'error', (err) ->
		console.log 'telnet:'.error, err.message.data

	client.on 'close', () ->
		# console.log parser.parse global.data
		# callback parseMessages(global.clientAnswer)
		if global.clientAnswer != ''
			callback global.controls.parser.snParseMessages global.clientAnswer
		else 
			console.log 'telnet:'.error, 'data not found'.data
			# throw new Error('data not found'.error)
		# callback global.clientAnswer

exports.insertMessageIntoBase = (data, cn, db, callback) ->
	global.controls.db.query global.controls.db.sms.insertMessage(data,cn), db, (result) ->
		callback result