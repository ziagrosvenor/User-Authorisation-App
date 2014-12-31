module.exports = function(User) {
  var LocalStrategy, bcrypt, passport;
  passport = require('passport');
  bcrypt = require('bcrypt');
  LocalStrategy = require('passport-local').Strategy;
  passport.use(new LocalStrategy(function(username, password, done) {
    return User.findOne({
      email: username
    }, function(err, user) {
      if (err) {
        return done(err);
      }
      if (!user) {
        console.log('no user');
        return done(null, false);
      }
      if (bcrypt.compareSync(password, user.password) === false) {
        return done(null, false, {
          message: 'Unknown user #{user.firstname}'
        });
      }
      return done(null, user);
    });
  }));
  passport.serializeUser(function(user, done) {
    return done(null, user.email);
  });
  passport.deserializeUser(function(email, done) {
    return done(null, {
      username: email
    });
  });
  return passport;
};
