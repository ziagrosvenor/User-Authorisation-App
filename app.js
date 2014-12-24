module.exports = function(Db) {
  var MongoStore, app, auth, bodyParser, cookieParser, express, passport, session;
  express = require('express');
  session = require('express-session');
  cookieParser = require('cookie-parser');
  bodyParser = require('body-parser');
  MongoStore = require('connect-mongo')(session);
  auth = require('./auth.js');
  passport = auth(Db.models.User);
  app = express();
  app.use(express["static"]('public'));
  app.set('view engine', 'jade');
  app.set('views', __dirname + '/views');
  app.use(cookieParser());
  app.use(bodyParser.json());
  app.use(bodyParser.urlencoded({
    extended: true
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
  app.get('/admin', function(req, res) {
    if (!req.session.username) {
      res.redirect('/');
    }
    return res.render('admin', {
      username: req.session.username
    });
  });
  app.post('/login', passport.authenticate('local', {
    failureRedirect: '/'
  }), function(req, res) {
    req.session.username = req.body.username;
    return res.redirect('/admin');
  });
  return app;
};
