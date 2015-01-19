# @cjsx React.DOM
React = require 'react'
AppActions = require '../../actions/app-actions'

DeletePost = React.createClass
  handleClick: () ->
    AppActions.deletePost(this.props.id)
  render: () ->
    <div className='btn' onClick={this.handleClick}>X</div>

module.exports = DeletePost