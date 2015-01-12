module.exports = function(User) {
  var Entities, bcrypt, entities, time;
  time = new Date;
  Entities = require('html-entities').XmlEntities;
  entities = new Entities;
  bcrypt = require('bcrypt');
  return {
    signup: function(req, res) {
      var newUser, password;
      password = entities.encode(req.body.password);
      newUser = new User({
        firstName: entities.encode(req.body.firstname),
        surname: entities.encode(req.body.surname),
        email: entities.encode(req.body.email),
        password: bcrypt.hashSync(password, bcrypt.genSaltSync(10)),
        timestamp: time.getTime()
      });
      return newUser.save(function(err) {
        if (err) {
          return res.send({
            message: 'fail'
          });
        } else {
          return res.send({
            message: 'success'
          });
        }
      });
    },
    login: function(req, res) {
      req.session.username = req.body.username;
      return res.redirect('/admin');
    },
    admin: function(req, res) {
      if (!req.session.username) {
        res.redirect('/');
      }
      return res.render('admin', {
        username: req.session.username
      });
    }
  };
};
