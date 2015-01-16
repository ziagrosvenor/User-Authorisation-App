module.exports = function(Schema) {
  var Activity, UserSchema;
  Activity = new Schema({
    type: String,
    seen: Boolean,
    timestamp: Number
  });
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
    activity: [Activity],
    timestamp: Number
  });
  return UserSchema;
};
