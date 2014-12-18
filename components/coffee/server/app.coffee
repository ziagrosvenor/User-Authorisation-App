express = require('express')
session = require 'express-session'
cookieParser = require 'cookie-parser'
bodyParser = require('body-parser')
mongoose = require('./data/database.js')()
MongoStore = require('connect-mongo')(session)
userModel = require('./data/bind-models.js')(mongoose.db)

app = express()

app.set('view engine', 'jade')
app.set('views', __dirname + '/views')
app.use(cookieParser())
app.use(session
	secret: '73f70b7v9s'
	resave: true
	saveUninitialized: true
	store: new MongoStore
		db: mongoose.con
		)
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({extended: true}))
app.use(express.static(__dirname, 'public'));

app.get('/', (req, res) ->
	res.render('index'))

module.exports = app