module.exports = function(Schema) {
  var UserSchema;
  UserSchema = new Schema({
    firstName: {
      type: String,
      required: true
    },
    surname: {
      type: String,
      required: true
    },
    email: {
      type: String,
      lowercase: true,
      required: true,
      unique: true
    },
    password: {
      type: String,
      required: true
    },
    timestamp: Number
  });
  return UserSchema;
};
