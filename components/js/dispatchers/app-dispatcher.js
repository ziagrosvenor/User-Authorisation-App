var AppDispatcher, Dispatcher, merge;

Dispatcher = require('./dispatcher');

merge = require('react/lib/merge');

AppDispatcher = merge(Dispatcher.prototype, {
  handleViewAction: function(action) {
    console.log('action', action);
    return this.dispatch({
      source: 'VIEW_ACTION',
      action: action
    });
  }
});

module.exports = AppDispatcher;
