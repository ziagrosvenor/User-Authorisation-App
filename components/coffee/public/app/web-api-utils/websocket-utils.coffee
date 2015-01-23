ServerActions = require '../actions/server-actions'
socket = require('socket.io-client')()

SocketUtils =
  listenForCreatedPost: ->
    socket.on 'post_saved', (data) ->
      ServerActions.recieveCreatedPost(data)

module.exports = SocketUtils