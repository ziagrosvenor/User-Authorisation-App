# Database object contains models and con as properties
Db = require('./data/database.js')()

# Express app.
app = require('./app.js')(Db)

server = app.listen(3000, () ->
	console.log('listening....')
)