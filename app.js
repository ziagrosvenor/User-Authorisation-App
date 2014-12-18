var app, bodyParser, db, express, models;

express = require('express');

bodyParser = require('body-parser');

db = require('./data/database.js')();

models = require('./data/bind-models.js')(db);

app = express();

app.set('view engine', 'jade');

app.set('views', __dirname + '/views');

app.use(bodyParser.json());

app.use(bodyParser.urlencoded({
  extended: true
}));

app.use(express["static"](__dirname, 'public'));

app.get('/', function(req, res) {
  return res.render('index');
});

module.exports = app;
