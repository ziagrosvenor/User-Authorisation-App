express = require('express')
bodyParser = require('body-parser')
db = require('./database.js')()
models = require('./bind-models.js')(db)

app = express()

app.set('view engine', 'jade')
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({extended: true}))
app.use(express.static(path.join(__dirname, 'public')))

module.exports = app