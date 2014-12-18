var app, server;

app = require('./app');

server = app.listen(3000, function() {
  return console.log('listening....');
});
