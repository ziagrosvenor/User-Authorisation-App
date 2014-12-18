module.exports = (db) ->
  Schema = db.Schema
  UserSchema = require('./server/models/user-model.js')(Shema)