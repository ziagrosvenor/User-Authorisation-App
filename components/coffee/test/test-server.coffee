Db = require('../data/database.js')()

app = require '../app'

app = app(Db)

server = app.listen 2999, () ->
	console.log('Listening for tests')

module.exports = app