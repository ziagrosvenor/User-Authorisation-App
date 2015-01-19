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
  postRoutes = require('./routes/post-routes')(Posts, User);
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
  app.get('/api/user', function(req, res) {
    if (!req.session) {
      return;
    }
    return User.find({
      email: req.session.username
    }, function(err, user) {
      return res.send(user);
    });
  });
  app.get('/api/users', function(req, res) {
    if (!req.session) {
      return;
    }
    return User.find(function(err, users) {
      if (err) {
        console.error(err);
        res.status(404);
        res.send({
          success: false
        });
      }
      return res.send(users);
    });
  });
  app.put('/api/user', function(req, res) {
    if (!req.session) {
      return;
    }
    return User.update({
      email: req.session.username,
      "activity.seen": false
    }, {
      $set: {
        "activity.$.seen": true
      }
    }, {
      upsert: false,
      multi: true
    }, function(err, num) {
      if (err) {
        return console.error(err);
      }
      console.log(num);
      return res.send({
        success: true
      });
    });
  });
  app.route('/api/posts').get(postRoutes.read).post(postRoutes.create).put(postRoutes.update)["delete"](postRoutes["delete"]);
  return app;
};
