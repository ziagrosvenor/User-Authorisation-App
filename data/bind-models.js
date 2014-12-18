module.exports = function(db) {
  var Schema, UserSchema;
  Schema = db.Schema;
  UserSchema = require('./user-model.js')(Schema);
  return db.model('UserModel', UserSchema);
};
