module.exports = function(db) {
  var Schema, UserSchema;
  Schema = db.Schema;
  return UserSchema = require('./server/models/user-model.js')(Shema);
};
