
exports.opendb = (callback) ->

	colors = global.controls.lib.colors.init()

	conf = global.dbsettings.connections.fdb
	fb = require 'node-firebird'
	fb.attach
		host: conf.path.replace(/\:(.*)/g,'')
		database: conf.path.replace(/(.*?)\:/g,'')
		user: conf.login
		password: conf.password
		(err, db) ->
			if (err)
				console.log err.message.error
			else
				console.log "connected to ".data+"fdb".info
				callback(db)

exports.checkError = (err) ->
	throw new Error err.message  if err

exports.check = (tr, callback) ->
	(err, param) ->
		if (!err)
			callback err, param
		else
			tr.rollback()
			throw new Error err.message

