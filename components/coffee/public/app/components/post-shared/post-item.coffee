# @cjsx React.DOM
React = require 'react'

Post = React.createClass
  render: ->
    <div className="post">
      <h2>{this.props.data.title}</h2>
      <h5>{this.props.data.author}</h5>
      <p>{this.props.data.content}</p>
      <h6>{this.props.data.updated}</h6>
      <div>
        {@props.children}
      </div>
    </div>

module.exports = Post