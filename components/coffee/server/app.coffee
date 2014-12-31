module.exports = (Db) ->
  # HTTP server
  express = require 'express'

  # Session middleware
  session = require 'express-session'
  cookieParser = require 'cookie-parser'

  # Parsing HTTP request body
  bodyParser = require 'body-parser'

  # Store session in Mongo Db
  MongoStore = require('connect-mongo')(session)

  # Module function returns passport instance.
  auth = require './auth.js'

  bcrypt = require 'bcrypt'

  User = Db.models.User
  time = new Date
  passport = auth(User)
  app = express()

  app.use express.static 'public'
  app.set 'view engine', 'jade'
  app.set 'views', __dirname + '/views'
  app.use cookieParser()
  app.use bodyParser.json()
  app.use bodyParser.urlencoded(extended: true)
  app.use passport.initialize()
  app.use passport.session()
  app.use session
    secret: '73f70b7v9s'
    resave: true
    saveUninitialized: true
    store: new MongoStore
      mongoose_connection: Db.con

  app.get '/', (req, res) ->
    res.render 'index'

  app.get '/admin', (req, res) ->
    if !req.session.username
      res.redirect '/'
    res.render 'admin', username: req.session.username

  app.post '/login',
    passport.authenticate('local', failureRedirect: '/'),
    (req, res) ->
      req.session.username = req.body.username
      res.redirect '/admin'

  app.post '/signup',
    (req, res) ->
      newUser = new User
        firstName: req.body.firstname
        surname: req.body.surname
        email: req.body.email
        password: bcrypt.hashSync(req.body.password, bcrypt.genSaltSync(10))
        timestamp: time.getTime()

      newUser.save (err) ->
        if err
          console.error(err)
        else
          console.log('User saved')

      res.redirect '/'

  app