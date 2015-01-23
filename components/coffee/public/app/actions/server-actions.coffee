AppConstants = require '../constants/app-constants'
AppDispatcher = require '../dispatchers/app-dispatcher'

ServerActions =
  recieveUserDetails: (user) ->
    AppDispatcher.handleServerAction
      actionType: AppConstants.RECIEVE_USER
      user: user

  recieveAllPosts: (posts) ->
    AppDispatcher.handleServerAction
      actionType: AppConstants.RECIEVE_POSTS
      posts: posts

  recieveCreatedPost: (post) ->
    AppDispatcher.handleServerAction
      actionType: AppConstants.RECIEVE_CREATED_POST
      post: post

module.exports = ServerActions