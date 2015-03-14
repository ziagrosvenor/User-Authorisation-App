# @cjsx React.DOM
React = require 'react'
{Paper, Checkbox} = require 'material-ui'
moment = require 'moment'


Post = React.createClass
  render: ->
    date = @props.data.updated
    postUpdateTime = moment(date).fromNow()

    <Paper zDepth={1}>
      <div className="post">
        <h2 className="post-title">{this.props.data.title}</h2>
        <p className="post-content">{this.props.data.content}</p>

        <div className="post-row">
          <h6 className="post-date">{postUpdateTime}</h6>
          <div className="post-likes">

            <span >Likes {this.props.data.likes.length}</span>
          </div>
          <div className="post-ui">
            {@props.children}
          </div>
        </div>
      </div>
    </Paper>

module.exports = Post