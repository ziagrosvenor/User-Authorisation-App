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
    socket.on 'other_user_posts_found', (posts) ->
      ServerActions.recieveOtherUsersPosts(posts)
    socket.on 'other_user_found', (user) ->
      ServerActions.recieveOtherUser(user)
    socket.on 'post_like_added', (like) ->
      ServerActions.recievePostLikesUpdate(like)
    socket.on 'activity_added', (activity) ->
      ServerActions.recieveActivityUpdate(activity)
  getUsers: (searchPhrase) ->
    socket.emit 'get_users', searchPhrase
  postLiked: (data) ->
    socket.emit 'post_liked', data
  getOtherUser: (id) ->
    socket.emit 'get_other_user', id

module.exports = SocketUtils