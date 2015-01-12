module.exports = function(db) {
  var PostSchema, Schema, UserSchema;
  Schema = db.Schema;
  UserSchema = require('./user-model.js')(Schema);
  PostSchema = require('./post-model.js')(Schema);
  return {
    User: db.model('UserModel', UserSchema),
    Posts: db.model('PostModel', PostSchema)
  };
};
