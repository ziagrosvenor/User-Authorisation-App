module.exports = function(Schema) {
  var UserSchema;
  UserSchema = new Schema({
    username: String,
    password: String,
    timestamp: Number
  });
  return UserSchema;
};
