module.exports = (Schema) ->
  Activity = new Schema
    userId: String
    type: String
    seen: Boolean
    timestamp: Number
    # Define scheme for user
  UserSchema = new Schema
    firstName:
      type: String
      required: true
    surname:
      type: String
      required: true
    email:
      type: String
      lowercase: true
      required: true
      unique: true
    password:
      type: String
      required: true
    activity: [Activity]
    timestamp: Number

  UserSchema