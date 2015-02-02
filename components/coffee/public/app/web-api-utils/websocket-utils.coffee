ServerActions = require '../actions/server-actions'
socket = require('socket.io-client')()

SocketUtils =
  listenForServerEvents: ->
    socket.on 'post_saved', (post) ->
      ServerActions.recieveCreatedPost(post)
    socket.on 'post_updated', (post) ->
      ServerActions.recieveUpdatedPost(post)
    socket.on 'users_found', (users) ->
      ServerActions.recieveUsers(users)
  getUsers: (searchPhrase) ->
    socket.emit 'get_users', searchPhrase

module.exports = SocketUtils