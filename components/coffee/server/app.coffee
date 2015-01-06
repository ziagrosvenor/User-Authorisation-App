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

  # Various security middleware for Express
  helmet = require 'helmet'

  # For password encryption.
  bcrypt = require 'bcrypt'

  # For XML entity encoding.
  Entities = require('html-entities').XmlEntities

  entities = new Entities

  User = Db.models.User
  time = new Date
  passport = auth(User)
  app = express()

  app.set 'view engine', 'jade'
  app.set 'views', __dirname + '/views'
  app.use express.static 'public'
  app.use helmet.crossdomain()
  app.use helmet.frameguard('SAMEORIGIN')
  app.use helmet.hidePoweredBy(setTo: 'PHP 4.2.0')
  app.use helmet.hsts(maxAge: 31536000)
  app.use helmet.xssFilter(setOnOldIE: true)
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
      password = entities.encode(req.body.password)
      
      newUser = new User
        firstName: entities.encode(req.body.firstname)
        surname: entities.encode(req.body.surname)
        email: entities.encode(req.body.email)
        password: bcrypt.hashSync(password, bcrypt.genSaltSync(10))
        timestamp: time.getTime()

      newUser.save (err) ->
        if err
          res.send message: 'fail'
        else
          res.send message: 'success'
  app