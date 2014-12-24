module.exports = function() {
  var Mongoose, UserModel, con, db;
  Mongoose = require('mongoose');
  db = Mongoose.connect('mongodb://localhost/user-auth');
  con = Mongoose.connection;
  con.on('error', console.error.bind(console, 'connection error'));
  UserModel = require('./bind-models.js')(Mongoose);
  return {
    models: {
      User: UserModel
    },
    con: con
  };
};
