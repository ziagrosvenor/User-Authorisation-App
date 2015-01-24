ServerActions = require '../actions/server-actions'
_user = require('../factory/user-factory')()
_users = require '../factory/users-factory'
_posts = require '../factory/app-factory'

AJAXUtils =
  getCurrentUser: ->
    _user.get().then (result) ->
      ServerActions.recieveUserDetails(result)

  getAllUsers: ->
    _users.get().then (result) ->
      ServerActions.recieveAllUsers(result)

  getCurrentUserPosts: ->
    _posts.get().then (result) ->
      ServerActions.recieveAllPosts(result)

  getInitialData: ->
    @getCurrentUser()
    @getAllUsers()
    @getCurrentUserPosts()

module.exports = AJAXUtils