# @cjsx React.DOM
React = require 'react'
AppActions = require '../actions/app-actions'
Posts = require '../components/app-posts'

APP = React.createClass
	handleClick: () ->
		AppActions.addPost('This is a post')
	render: () ->
		<div>
			<Posts/>
		</div>

module.exports = APP