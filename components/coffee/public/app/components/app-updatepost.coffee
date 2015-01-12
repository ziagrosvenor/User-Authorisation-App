# @cjsx React.DOM
React = require 'react'
AppActions = require '../actions/app-actions'

UpdatePost = React.createClass
	handleClick: () ->
		AppActions.updatePost(this.props.index)
	render: () ->
		<div className='btn' onClick={this.handleClick}>Update Post</div>

module.exports = UpdatePost