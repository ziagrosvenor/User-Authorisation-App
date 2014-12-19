express = require('express')
session = require 'express-session'
cookieParser = require 'cookie-parser'
auth = require './auth.js'
bodyParser = require('body-parser')
mongoose = require('./data/database.js')()
MongoStore = require('connect-mongo')(session)
userModel = require('./data/bind-models.js')(mongoose.db)

passport = auth(userModel)
app = express()

app.use express.static 'public' 
app.set('view engine', 'jade')
app.set('views', __dirname + '/views')
app.use(cookieParser())
app.use passport.initialize()
app.use passport.session()
app.use session
	secret: '73f70b7v9s'
	resave: true
	saveUninitialized: true
	store: new MongoStore
		mongoose_connection: mongoose.con
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({extended: true}))
app.use(express.static(__dirname, 'public'));

app.get '/', (req, res) ->
	res.render('index')

app.get '/admin', (req, res) ->
	res.render('admin', username: req.session.username)

app.post '/login',
	passport.authenticate('local', failureRedirect: '/'),
	(req, res) ->
		req.session.username = req.body.username
		res.redirect '/admin'
module.exports = app