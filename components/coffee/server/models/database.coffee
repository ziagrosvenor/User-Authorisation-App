module.exports = () ->
  Mongoose = require('mongoose')
  db = Mongoose.connect('mongodb://localhost/blog')
  con = Mongoose.connection
  con.on('error', console.error.bind(console, 'connection error'))

  Models = require('./bind-models.js')(Mongoose)

  # function returns Mongoose models and connection
  models:
  	User: Models.User
  	Posts: Models.Posts 
  con: con