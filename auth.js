module.exports = function(User) {
  var LocalStrategy, passport;
  passport = require('passport');
  LocalStrategy = require('passport-local').Strategy;
  passport.use(new LocalStrategy(function(username, password, done) {
    return User.findOne({
      username: username
    }, function(err, user) {
      if (err) {
        return done(err);
      }
      if (!user) {
        return done(null, false);
      }
      if (user.password !== password) {
        return done(null, false, {
          message: 'Unknown user #{username}'
        });
      }
      return done(null, user);
    });
  }));
  passport.serializeUser(function(user, done) {
    return done(null, user.username);
  });
  passport.deserializeUser(function(username, done) {
    return done(null, {
      username: username
    });
  });
  return passport;
};
