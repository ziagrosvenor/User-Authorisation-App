# @cjsx React.DOM
React = require 'react'
AppActions = require '../../actions/app-actions'
injectTapEventPlugin = require 'react-tap-event-plugin'
injectTapEventPlugin()

LikeBtn = React.createClass
  handleTap: ->
    likeData =
      authorId: @props.authorId
      postId: @props.postId
      userInSessionId: @props.userInSessionId
    AppActions.postLiked(likeData)

  render: () ->
    <div className='btn' onTouchTap={this.handleTap}>Like</div>

module.exports = LikeBtn