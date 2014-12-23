var Db, MongoStore, UserModel, app, auth, bodyParser, cookieParser, express, passport, session;

express = require('express');

session = require('express-session');

cookieParser = require('cookie-parser');

bodyParser = require('body-parser');

Db = require('./data/database.js')();

MongoStore = require('connect-mongo')(session);

UserModel = require('./data/bind-models.js')(Db.model);

auth = require('./auth.js');

passport = auth(UserModel);

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

module.exports = app;
