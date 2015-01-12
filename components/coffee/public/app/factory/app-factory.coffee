request = require 'superagent'
Q = require 'q'

module.exports = () ->
	deferredGet = Q.defer()
	deferredPost = Q.defer()

	request.get '/api/posts', (res) ->
		if res.status == 200
			deferredGet.resolve(res.body)
		else
			deferredGet.reject('Status code {res.status}')

	get: deferredGet.promise
	post: (data) ->
		request.post('/api/posts')
			.send(data)
			.set('Accept', 'application/json')
			.end (res) ->
				if res.status == 200
					deferredPost.resolve(res.body)
				else
					deferredPost.reject('Status code {res.status}')
		return deferredPost