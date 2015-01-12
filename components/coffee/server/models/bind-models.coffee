module.exports = (db) ->
  Schema = db.Schema
  UserSchema = require('./user-model.js')(Schema)
  PostSchema = require('./post-model.js')(Schema)
  
  User: db.model('UserModel', UserSchema)
  Posts: db.model('PostModel', PostSchema)