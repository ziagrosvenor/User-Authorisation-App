var MongoStore, app, bodyParser, cookieParser, express, mongoose, session, userModel;

express = require('express');

session = require('express-session');

cookieParser = require('cookie-parser');

bodyParser = require('body-parser');

mongoose = require('./data/database.js')();

MongoStore = require('connect-mongo')(session);

userModel = require('./data/bind-models.js')(mongoose.db);

app = express();

app.use(express["static"]('public'));

app.set('view engine', 'jade');

app.set('views', __dirname + '/views');

app.use(cookieParser());

app.use(session({
  secret: '73f70b7v9s',
  resave: true,
  saveUninitialized: true,
  store: new MongoStore({
    mongoose_connection: mongoose.con
  })
}));

app.use(bodyParser.json());

app.use(bodyParser.urlencoded({
  extended: true
}));

app.use(express["static"](__dirname, 'public'));

app.get('/', function(req, res) {
  return res.render('index');
});

module.exports = app;
