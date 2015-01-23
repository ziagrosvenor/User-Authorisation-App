module.exports = (Db) ->
  # Express application
  express = require 'express'

  # Session middleware
  session = require 'express-session'
  cookieParser = require 'cookie-parser'

  # Parsing HTTP request body
  bodyParser = require 'body-parser'

  # Store session in Mongo Db
  MongoStore = require('connect-mongo')(session)

  # Various security middleware for Express
  helmet = require 'helmet'

  User = Db.models.User
  Posts = Db.models.Posts

  # Module function returns passport instance.
  auth = require './auth.js'

  passport = auth(User)
  app = express()

  app.set 'view engine', 'jade'
  app.set 'views', __dirname + '/views'
  app.use express.static 'public'

  app.use cookieParser()
  app.use bodyParser.json()
  app.use bodyParser.urlencoded(extended: true)

  # Security middleware
  app.use helmet.crossdomain()
  app.use helmet.frameguard('SAMEORIGIN')
  app.use helmet.hidePoweredBy(setTo: 'PHP 4.2.0')
  app.use helmet.hsts(maxAge: 31536000)
  app.use helmet.xssFilter(setOnOldIE: true)

  sessionStore = session
    secret: '73f70b7v9s'
    resave: true
    saveUninitialized: true
    store: new MongoStore
      mongoose_connection: Db.con

  # Password validation and session cookie middleware
  app.use passport.initialize()
  app.use passport.session()
  app.use sessionStore

  # HTTP server
  http = require('http').Server(app)
  # Web socket events
  io = require('socket.io')(http)

  # Modules returns user and post route middlewares as methods
  userRoutes = require('./routes/user-routes')(User)
  postRoutes = require('./routes/post-routes')(Posts, User)

  io.use (socket, next) ->
    if socket.request.headers.cookie
      return next()
    return next(new Error 'authentication error')

  socketEvents = require('./web-sockets/socket-events')(io, Posts, User,)

  app.get '/', (req, res) ->
    res.render 'index'

  app.get '/admin', userRoutes.admin

  app.post '/login',
    passport.authenticate('local', failureRedirect: '/'),
    userRoutes.login

  app.post '/signup', userRoutes.signup

  app.get '/api/user', (req, res) ->
    if !req.session
      return
    User.findOne email: req.session.username, (err, user) ->
      res.send(user)

  app.get '/api/users', (req, res) ->
    if !req.session
      return
    User.find (err, users) ->
      if err
        console.error(err)
        res.status(404)
        res.send(success: false)
      res.send(users)

  app.put '/api/user', (req, res) ->
    if !req.session
      return

    User.update
      email: req.session.username,
      "activity.seen": false,
        $set:
          "activity.$.seen": true
      ,
      upsert: false,
      multi: true
      (err, num) ->
        if err 
          return console.error(err)
        console.log(num)
        res.send(success: true)

  app.route '/api/posts'
    .get postRoutes.read
    .post postRoutes.create
    .put postRoutes.update
    .delete postRoutes.delete

  http