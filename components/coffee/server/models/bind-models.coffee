module.exports = (db) ->
  Schema = db.Schema
  UserSchema = require('./user-model.js')(Schema)
  db.model('UserModel', UserSchema)