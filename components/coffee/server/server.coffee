# Database object contains models and con as properties.
Db = require('./data/database.js')()

# Express app.
app = require('./app.js')(Db)

# Server listening on port 3000.
server = app.listen 3000, () ->
    console.log 'listening....'