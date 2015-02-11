module.exports = function(Db) {
  var MongoStore, Posts, Users, app, auth, bodyParser, cookieParser, express, helmet, http, io, passport, postRoutes, session, sessionStore, socketEvents, userRoutes;
  express = require('express');
  session = require('express-session');
  cookieParser = require('cookie-parser');
  bodyParser = require('body-parser');
  MongoStore = require('connect-mongo')(session);
  helmet = require('helmet');
  Users = Db.models.User;
  Posts = Db.models.Posts;
  auth = require('./auth.js');
  passport = auth(Users);
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
  sessionStore = session({
    secret: '73f70b7v9s',
    resave: true,
    saveUninitialized: true,
    store: new MongoStore({
      mongoose_connection: Db.con
    })
  });
  app.use(passport.initialize());
  app.use(passport.session());
  app.use(sessionStore);
  http = require('http').Server(app);
  io = require('socket.io')(http);
  userRoutes = require('./routes/user-routes')(Users);
  postRoutes = require('./routes/post-routes')(Posts, Users);
  io.use(function(socket, next) {
    if (socket.request.headers.cookie) {
      return next();
    }
    return next(new Error('authentication error'));
  });
  socketEvents = require('./web-sockets/socket-events')(io, Posts, Users);
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
    return Users.findOne({
      email: req.session.username
    }, function(err, user) {
      return res.send(user);
    });
  });
  app.get('/api/users', function(req, res) {
    if (!req.session) {
      return;
    }
    return Users.find(function(err, users) {
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
    return Users.update({
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
      return res.send({
        success: true
      });
    });
  });
  app.route('/api/posts').get(postRoutes.read).post(postRoutes.create).put(postRoutes.update)["delete"](postRoutes["delete"]);
  return http;
};
