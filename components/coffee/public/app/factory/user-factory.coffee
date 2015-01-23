request = require 'superagent'
Q = require 'q'

module.exports = ->
  get: ->
    deferred = Q.defer()

    request.get '/api/user', (res) ->
      if res.status == 200
        deferred.resolve(res.body)
      else
        deferred.reject('Status #{req.body.status}')

    return deferred.promise
    
  updateActivity: ->
    deferred = Q.defer()

    request.put('/api/user')
      .send(seen: true)
      .end (res) ->
        if res.status == 200
          deferred.resolve(res.body)
        else
          deferred.reject('Status #{req.body.status}')

    return deferred.promise