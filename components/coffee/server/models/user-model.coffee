module.exports = (Schema) ->
	UserSchema = new Schema
		username: String
		password: String
		timestamp: Number

	UserSchema