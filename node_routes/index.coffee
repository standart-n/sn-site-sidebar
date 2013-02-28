
exports.index = (req, res) ->

	colors = global.controls.lib.colors.init()

	# global.controls.db.opendb (db) ->
	# 	db.query global.controls.sql.getUserList(), (err, result) ->
	# 		console.log(result)

	console.log 'render: '.data+'index'.info
	res.render 'index'
