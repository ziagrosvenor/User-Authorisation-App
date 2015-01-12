AppConstants = require '../constants/app-constants'
AppDispatcher = require '../dispatchers/app-dispatcher.js'

AppActions =
	addPost: (post) ->
		AppDispatcher.handleViewAction
			actionType: AppConstants.ADD_POST
			post: post
	updatePost: (index) ->
		AppDispatcher.handleViewAction
			actionType: AppConstants.UPDATE_POST
			index: index
	deletePost: (index) ->
		AppDispatcher.handleViewAction
			actionType: AppConstants.DELETE_POST
			index: index

module.exports = AppActions