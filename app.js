module.exports = function(Db) {
  var MongoStore, User, app, auth, bcrypt, bodyParser, cookieParser, express, passport, session, time;
  express = require('express');
  session = require('express-session');
  cookieParser = require('cookie-parser');
  bodyParser = require('body-parser');
  MongoStore = require('connect-mongo')(session);
  auth = require('./auth.js');
  bcrypt = require('bcrypt');
  User = Db.models.User;
  time = new Date;
  passport = auth(User);
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
  app.post('/signup', function(req, res) {
    var newUser;
    newUser = new User({
      firstName: req.body.firstname,
      surname: req.body.surname,
      email: req.body.email,
      password: bcrypt.hashSync(req.body.password, bcrypt.genSaltSync(10)),
      timestamp: time.getTime()
    });
    newUser.save(function(err) {
      if (err) {
        return console.error(err);
      } else {
        return console.log('User saved');
      }
    });
    return res.redirect('/');
  });
  return app;
};
