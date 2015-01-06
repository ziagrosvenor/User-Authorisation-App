module.exports = function(Db) {
  var Entities, MongoStore, User, app, auth, bcrypt, bodyParser, cookieParser, entities, express, helmet, passport, session, time;
  express = require('express');
  session = require('express-session');
  cookieParser = require('cookie-parser');
  bodyParser = require('body-parser');
  MongoStore = require('connect-mongo')(session);
  auth = require('./auth.js');
  helmet = require('helmet');
  bcrypt = require('bcrypt');
  Entities = require('html-entities').XmlEntities;
  entities = new Entities;
  User = Db.models.User;
  time = new Date;
  passport = auth(User);
  app = express();
  app.set('view engine', 'jade');
  app.set('views', __dirname + '/views');
  app.use(express["static"]('public'));
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
    var newUser, password;
    password = entities.encode(req.body.password);
    newUser = new User({
      firstName: entities.encode(req.body.firstname),
      surname: entities.encode(req.body.surname),
      email: entities.encode(req.body.email),
      password: bcrypt.hashSync(password, bcrypt.genSaltSync(10)),
      timestamp: time.getTime()
    });
    return newUser.save(function(err) {
      if (err) {
        return res.send({
          message: 'fail'
        });
      } else {
        return res.send({
          message: 'success'
        });
      }
    });
  });
  return app;
};
