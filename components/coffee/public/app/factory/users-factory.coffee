request = require 'superagent'
Q = require 'q'

module.exports =
  get: ->
    deferred = Q.defer()

    request.get '/api/users', (res) ->
      if res.status == 200
        deferred.resolve(res.body)
      else
        deferred.reject('Status #{req.body.status}')

    return deferred.promise