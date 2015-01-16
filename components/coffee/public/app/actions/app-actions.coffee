AppConstants = require '../constants/app-constants'
AppDispatcher = require '../dispatchers/app-dispatcher'

AppActions =
    addPost: (post) ->
        AppDispatcher.handleViewAction
            actionType: AppConstants.ADD_POST
            post: post
    updatePost: (post) ->
        AppDispatcher.handleViewAction
            actionType: AppConstants.UPDATE_POST
            post: post
    deletePost: (id) ->
        AppDispatcher.handleViewAction
            actionType: AppConstants.DELETE_POST
            id: id

module.exports = AppActions