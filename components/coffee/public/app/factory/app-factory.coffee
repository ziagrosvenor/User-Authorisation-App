request = require 'superagent'
Q = require 'q'

module.exports =
  get: () ->
    deferred = Q.defer()
    request.get '/api/posts', (res) ->
      if res.status == 200
        deferred.resolve(res.body)
      else
        deferred.reject('Status code #{res.status}')
    deferred.promise
  post: (data) ->
    deferred = Q.defer()
    request.post('/api/posts')
      .send(data)
      .set('Accept', 'application/json')
      .end (res) ->
        if res.status == 200
          deferred.resolve(res.body)
        else
          deferred.reject('Status code #{res.status}')
    return deferred.promise
  update: (data) ->
    deferred = Q.defer()
    request.put('/api/posts')
      .send(data)
      .set('Accept', 'application/json')
      .end (res) ->
        if res.status == 200
          deferred.resolve(res.body)
        else
          deferred.reject('Status code #{res.status}')
    return deferred.promise
  delete: (postId) ->
    deferred = Q.defer()
    request.del('/api/posts')
      .send(id:postId)
      .set('Accept', 'application/json')
      .end (res) ->
        if res.status == 200
          deferred.resolve(res.body)
        else
          console.error('fail')
    return deferred.promise