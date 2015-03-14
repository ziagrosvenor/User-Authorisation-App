module.exports = (Schema) ->
  Activity = new Schema
    userId: String
    type: String
    seen: Boolean
    timestamp: Number

  Job = new Schema
    role: String
    description: String
    location: String
    details:
      employerName: String
      rating: Number
      typeOfWork: String
      wage: String
      workTimes: String
      startDate: Date
      endDate: Date
    meta:
      type: String
      dateAdded: Date
      deleted: String
    author:
      id: String
      email: String
      name: String

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
    jobHistory: [Job]
    timestamp: Number

  UserSchema