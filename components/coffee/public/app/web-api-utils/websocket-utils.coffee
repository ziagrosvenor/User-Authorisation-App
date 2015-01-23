ServerActions = require '../actions/server-actions'
socket = require('socket.io-client')()

SocketUtils =
  listenForServerEvents: ->
    socket.on 'post_saved', (data) ->
      ServerActions.recieveCreatedPost(data)
    socket.on 'post_updated', (data) ->
      console.log data

module.exports = SocketUtils