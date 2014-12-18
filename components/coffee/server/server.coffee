app = require('./app')
server = app.listen(3001, () ->
	console.log('listening....')
)