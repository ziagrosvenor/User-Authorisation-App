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

  recieveUsers: (users) ->
    AppDispatcher.handleServerAction
      actionType: AppConstants.RECIEVE_ALL_USERS
      users: users

  recieveCreatedPost: (post) ->
    AppDispatcher.handleServerAction
      actionType: AppConstants.RECIEVE_CREATED_POST
      post: post

  recieveUpdatedPost: (post) ->
    AppDispatcher.handleServerAction
      actionType: AppConstants.RECIEVE_UPDATED_POST
      post: post

  recieveOtherUsersPosts: (posts) ->
    AppDispatcher.handleServerAction
      actionType: AppConstants.RECIEVE_OTHER_USERS_POSTS
      posts: posts

  recieveOtherUser: (user) ->
    AppDispatcher.handleServerAction
      actionType: AppConstants.RECIEVE_OTHER_USER
      user: user

  recievePostLikesUpdate: (like) ->
    AppDispatcher.handleServerAction
      actionType: AppConstants.RECIEVE_POST_LIKES_UPDATE
      like: like

  recieveActivityUpdate: (activity) ->
    AppDispatcher.handleServerAction
      actionType: AppConstants.RECIEVE_ACTIVITY_UPDATE
      activity: activity

module.exports = ServerActions