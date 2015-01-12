module.exports = function(Db) {
  var MongoStore, Posts, User, app, auth, bodyParser, cookieParser, express, helmet, passport, postRoutes, session, time, userRoutes;
  express = require('express');
  session = require('express-session');
  cookieParser = require('cookie-parser');
  bodyParser = require('body-parser');
  MongoStore = require('connect-mongo')(session);
  helmet = require('helmet');
  time = new Date;
  User = Db.models.User;
  Posts = Db.models.Posts;
  auth = require('./auth.js');
  userRoutes = require('./routes/user-routes')(User);
  postRoutes = require('./routes/post-routes')(Posts);
  passport = auth(User);
  app = express();
  app.set('view engine', 'jade');
  app.set('views', __dirname + '/views');
  app.use(express["static"]('public'));
  app.use(cookieParser());
  app.use(bodyParser.json());
  app.use(bodyParser.urlencoded({
    extended: true
  }));
  app.use(helmet.crossdomain());
  app.use(helmet.frameguard('SAMEORIGIN'));
  app.use(helmet.hidePoweredBy({
    setTo: 'PHP 4.2.0'
  }));
  app.use(helmet.hsts({
    maxAge: 31536000
  }));
  app.use(helmet.xssFilter({
    setOnOldIE: true
  }));
  app.use(passport.initialize());
  app.use(passport.session());
  app.use(session({
    secret: '73f70b7v9s',
    resave: true,
    saveUninitialized: true,
    store: new MongoStore({
      mongoose_connection: Db.con
    })
  }));
  app.get('/', function(req, res) {
    return res.render('index');
  });
  app.get('/admin', userRoutes.admin);
  app.post('/login', passport.authenticate('local', {
    failureRedirect: '/'
  }), userRoutes.login);
  app.post('/signup', userRoutes.signup);
  app.route('/api/posts').get(postRoutes.read).post(postRoutes.create);
  return app;
};
