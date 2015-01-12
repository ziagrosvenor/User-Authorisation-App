module.exports = function() {
  var Models, Mongoose, con, db;
  Mongoose = require('mongoose');
  db = Mongoose.connect('mongodb://localhost/blog');
  con = Mongoose.connection;
  con.on('error', console.error.bind(console, 'connection error'));
  Models = require('./bind-models.js')(Mongoose);
  return {
    models: {
      User: Models.User,
      Posts: Models.Posts
    },
    con: con
  };
};
