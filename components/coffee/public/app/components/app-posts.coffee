# @cjsx React.DOM
React = require 'react'
AppActions = require '../actions/app-actions'
AppStore = require('../stores/app-store')
# AddPost = require '../components/app-updatepost'

DeletePost = React.createClass
	handleClick: () ->
		AppActions.deletePost(this.props.index)
	render: () ->
		<div className='btn' onClick={this.handleClick}>X</div>

Post = React.createClass
	render: ->
		<div className="post">
			<h2>{this.props.title}</h2>
			<p>{this.props.content}</p>
			<DeletePost index={this.props.id} />
		</div>

PostList = React.createClass
	render: ->
		posts = this.props.data.map (post, i) ->
			<Post title={post.title} 
				content={post.content} 
				key={i} 
				id={post._id}/>
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
		<form className='postForm form' onSubmit={this.handleSubmit}>
			<div className='form-group'>
				<input className='form-control' type='text' placeholder="What's New?" ref='title'/>
			</div>
			<div className='form-group'>
				<textarea className='form-control' placeholder="Share something" ref='content' />
			</div>
			<input className='btn' type='submit' value='Post'/>

		</form>

PostModule = React.createClass
	loadPostsFromServer: () ->
		`AppStore.getPosts().then( function (result) {
			console.log('get posts')
			if(this.isMounted()) {
				this.setState({
					data: result
				})
			}
		}.bind(this));`
	handlePostSubmit: (post) ->
		AppActions.addPost(post)
	getInitialState: () ->
		data: []
	componentWillMount: () ->
		AppStore.addChangeListener(this._onChange)
	componentWillUnmount: () ->
		AppStore.removeChangeListener(this._onChange)		
	_onChange: () ->
		this.loadPostsFromServer()
	componentDidMount: () ->
		this.loadPostsFromServer()
	render: () ->
		<div className="postModule">
			<h1>Posts!</h1>
			<PostForm onPostSubmit={this.handlePostSubmit} />
			<PostList data={this.state.data} />
		</div>

module.exports = PostModule