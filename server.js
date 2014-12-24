var Db, app, server;

Db = require('./data/database.js')();

app = require('./app.js')(Db);

server = app.listen(3000, function() {
  return console.log('listening....');
});
