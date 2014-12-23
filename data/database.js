module.exports = function() {
  var Mongoose, con, db;
  Mongoose = require('mongoose');
  db = Mongoose.connect('mongodb://localhost/user-auth');
  con = Mongoose.connection;
  con.on('error', console.error.bind(console, 'connection error'));
  return {
    model: Mongoose,
    con: con
  };
};
