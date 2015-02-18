# @cjsx React.DOM
React = require 'react'
AppActions = require '../../actions/app-actions'
injectTapEventPlugin = require 'react-tap-event-plugin'
injectTapEventPlugin()

DeletePost = React.createClass
  handleTap: ->
    AppActions.deletePost(this.props.id)
  render: () ->
    <button className='btn' id='deleteBtn' onTouchTap={this.handleTap}>X</button>

module.exports = DeletePost