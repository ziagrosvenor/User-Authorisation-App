ServerActions = require '../actions/server-actions'
_user = require('../factory/user-factory')()
_posts = require '../factory/app-factory'

AJAXUtils =
  getCurrentUser: ->
    _user.get().then (result) ->
      ServerActions.recieveUserDetails(result)

  getCurrentUserPosts: ->
    _posts.get().then (result) ->
      ServerActions.recieveAllPosts(result)

module.exports = AJAXUtils