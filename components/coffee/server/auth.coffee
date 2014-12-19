module.exports = (User) ->
	passport = require 'passport'
	LocalStrategy = require('passport-local').Strategy;

	passport.use new LocalStrategy (username, password, done) ->
		User.findOne( username: username , (err, user) ->
			if err 
				return done(err)
			if !user
				return done(null, false)
			if user.password != password
				return done(null, false, message: 'Unknown user #{username}')
			return done(null, user)
		)

	passport.serializeUser (user, done) ->
		done null, user.username

	passport.deserializeUser (username, done) ->
		done null, username: username

	passport