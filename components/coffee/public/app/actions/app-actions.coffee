AppConstants = require '../constants/app-constants'
AppDispatcher = require '../dispatchers/app-dispatcher'
AppStore = require '../stores/app-store'
socket = require('socket.io-client')()
_user = require('../factory/user-factory')()

AppActions =
  addPost: (post) ->
    post = AppStore.getNewPostData(post)
    AppDispatcher.handleViewAction
      actionType: AppConstants.VIEW_CREATE_POST
      post: post
    socket.emit 'new_post', post

  updatePost: (post) ->
    AppDispatcher.handleViewAction
      actionType: AppConstants.VIEW_UPDATE_POST
      post: post
    socket.emit 'update_post', post

  deletePost: (id) ->
    AppDispatcher.handleViewAction
      actionType: AppConstants.VIEW_DELETE_POST
      id: id
    socket.emit 'delete_post', id

  activitySeen: (id) ->
    AppDispatcher.handleViewAction
      actionType: AppConstants.ACTIVITY_SEEN
        
    _user.updateActivity()


module.exports = AppActions