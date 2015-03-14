# @cjsx React.DOM
React = require 'react'
AppActions = require '../../actions/app-actions'
{FloatingActionButton} = require "material-ui"

DeletePost = React.createClass
  handleTap: ->
    AppActions.deletePost(this.props.id)
  render: () ->
    <FloatingActionButton
      {...@props}
      onTouchTap={this.handleTap}
      mini={true}
    >
      X
    </FloatingActionButton>
module.exports = DeletePost