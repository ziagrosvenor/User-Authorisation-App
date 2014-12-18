var app, server;

app = require('./app');

server = app.listen(3001, function() {
  return console.log('listening....');
});
