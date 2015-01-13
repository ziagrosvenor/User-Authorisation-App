# @cjsx React.DOM
React = require 'react'
AppActions = require '../actions/app-actions'
Posts = require '../components/app-posts'
UserNav = require '../components/user-navigation'

APP = React.createClass
	handleClick: () ->
		AppActions.addPost('This is a post')
	render: () ->
		<div>
			<UserNav/>
			<Posts/>
		</div>

module.exports = APP