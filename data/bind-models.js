module.exports = function(db) {
  var Schema, UserSchema;
  Schema = db.Schema;
  return UserSchema = require('./user-model.js')(Schema);
};
