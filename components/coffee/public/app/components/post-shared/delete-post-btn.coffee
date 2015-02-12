# @cjsx React.DOM
React = require 'react'
AppActions = require '../../actions/app-actions'
injectTapEventPlugin = require 'react-tap-event-plugin'
injectTapEventPlugin()

DeletePost = React.createClass
  handleTap: ->
    AppActions.deletePost(this.props.id)
  render: () ->
    <div className='btn' onTouchTap={this.handleTap}>X</div>

module.exports = DeletePost