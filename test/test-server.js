var Db, app, server;

Db = require('../data/database.js')();

app = require('../app');

app = app(Db);

server = app.listen(2999, function() {
  return console.log('Listening for tests');
});

module.exports = app;
