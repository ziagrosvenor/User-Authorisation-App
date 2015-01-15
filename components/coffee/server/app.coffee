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

  # Various security middleware for Express
  helmet = require 'helmet'

  time = new Date
  User = Db.models.User
  Posts = Db.models.Posts

  # Module function returns passport instance.
  auth = require './auth.js'

  # Modules returns user middlewares as methods
  userRoutes = require('./routes/user-routes')(User)
  postRoutes = require('./routes/post-routes')(Posts)

  passport = auth(User)
  app = express()

  app.set 'view engine', 'jade'
  app.set 'views', __dirname + '/views'
  app.use express.static 'public'

  app.use cookieParser()
  app.use bodyParser.json()
  app.use bodyParser.urlencoded(extended: true)

  app.use helmet.crossdomain()
  app.use helmet.frameguard('SAMEORIGIN')
  app.use helmet.hidePoweredBy(setTo: 'PHP 4.2.0')
  app.use helmet.hsts(maxAge: 31536000)
  app.use helmet.xssFilter(setOnOldIE: true)

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

  app.get '/admin', userRoutes.admin

  app.post '/login',
    passport.authenticate('local', failureRedirect: '/'),
    userRoutes.login

  app.post '/signup', userRoutes.signup
  
  app.route '/api/posts'
    .get postRoutes.read
    .post postRoutes.create
    .put postRoutes.update
    .delete postRoutes.delete

  app