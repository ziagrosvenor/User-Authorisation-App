module.exports = (User) ->
	passport = require 'passport'
	bcrypt = require 'bcrypt'
	LocalStrategy = require('passport-local').Strategy

	passport.use new LocalStrategy (username, password, done) ->
		User.findOne( email: username , (err, user) ->
			if err 
				return done(err)
			if !user
				console.log('no user')
				return done(null, false)
			if bcrypt.compareSync(password, user.password) == false
				return done(null, false, message: 'Unknown user #{user.firstname}')
			return done(null, user)
		)

	passport.serializeUser (user, done) ->
		done null, user.email

	passport.deserializeUser (email, done) ->
		done null, username: email

	passport