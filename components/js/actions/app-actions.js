var AppActions, AppConstants, AppDispatcher;

AppConstants = require('../constants/app-constants');

AppDispatcher = require('../dispatchers/app-dispatcher.js');

AppActions = {
  addPost: function(post) {
    return AppDispatcher.handleViewAction({
      actionType: AppConstants.ADD_POST,
      post: post
    });
  },
  updatePost: function(index) {
    return AppDispatcher.handleViewAction({
      actionType: AppConstants.UPDATE_POST,
      index: index
    });
  },
  deletePost: function(index) {
    return AppDispatcher.handleViewAction({
      actionType: AppConstants.DELETE_POST,
      index: index
    });
  }
};

module.exports = AppActions;
