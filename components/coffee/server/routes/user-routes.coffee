module.exports = (User) ->
  # For timestamp
  time = new Date
  # For XML entity encoding.
  Entities = require('html-entities').XmlEntities
  entities = new Entities
  # For password encryption.
  bcrypt = require 'bcrypt'

  signup: (req, res) ->
    password = entities.encode(req.body.password)
    
    newUser = new User
      firstName: entities.encode(req.body.firstname)
      surname: entities.encode(req.body.surname)
      email: entities.encode(req.body.email)
      password: bcrypt.hashSync(password, bcrypt.genSaltSync(10))
      timestamp: time.getTime()

    newUser.save (err) ->
      if err
        res.send message: 'fail'
      else
        res.send message: 'success'

  login: (req, res) ->
    req.session.username = req.body.username
    res.redirect '/admin'

  admin: (req, res) ->
    if !req.session.username
      res.redirect '/'
    res.render 'admin', username: req.session.username