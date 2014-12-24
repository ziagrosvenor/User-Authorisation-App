var app, server;

app = require('../app');

server = app.listen(2999, function() {
  return console.log('Listening for tests');
});

module.exports = app;
