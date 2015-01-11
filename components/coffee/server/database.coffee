module.exports = () ->
  Mongoose = require('mongoose')
  db = Mongoose.connect('mongodb://localhost/blog')
  con = Mongoose.connection
  con.on('error', console.error.bind(console, 'connection error'))

  UserModel = require('./bind-models.js')(Mongoose)

  # function returns Mongoose models and connection
  models:
  	User: UserModel 
  con: con