# @cjsx React.DOM
React = require 'react'
AppActions = require '../actions/app-actions'
AppStore = require('../stores/app-store')
AddPost = require '../components/app-updatepost'

Post = React.createClass
	render: ->
		<div className="post">
			<h2>{this.props.title}</h2>
			<p>{this.props.content}</p>
			<AddPost index={this.props.key}/>
		</div>

PostList = React.createClass
	render: ->
		posts = this.props.data.map (post, i) ->
			<Post title={post.title} content={post.content} key={i} index={i}/>
		<div className='postList'>
			{posts}
		</div>

PostForm = React.createClass
	handleSubmit: (e) ->
		e.preventDefault()

		title = this.refs.title.getDOMNode().value.trim()
		content = this.refs.content.getDOMNode().value.trim()

		if !title || !content
			return

		this.props.onPostSubmit
			userId: 'ldldlkd'
			title: title
			content: content

		this.refs.title.getDOMNode().value = ''
		this.refs.content.getDOMNode().value = ''
		return

	render: ->
		<form className='postForm' onSubmit={this.handleSubmit}>
			<input type='text' placeholder="What's New?" ref='title'/>
			<textarea placeholder="Share something" ref='content' />
			<input className='btn' type='submit' value='Post'/>
		</form>

PostModule = React.createClass
	handlePostSubmit: (post) ->
		AppActions.addPost(post)
	getInitialState: () ->
		data: []
	componentWillMount: () ->
		AppStore.addChangeListener(this._onChange)
	_onChange: () ->
		`AppStore.getPosts().then( function (result) {
			if(this.isMounted()) {
				this.setState({
					data: result
				})
			}
		}.bind(this));`
	componentDidMount: () ->
		`AppStore.getPosts().then( function (result) {
			if(this.isMounted()) {
				this.setState({
					data: result
				})
			}
		}.bind(this));`
	render: () ->
		<div className="postModule">
			<h1>Posts!</h1>
			<PostForm onPostSubmit={this.handlePostSubmit} />
			<PostList data={this.state.data} />
		</div>

module.exports = PostModule