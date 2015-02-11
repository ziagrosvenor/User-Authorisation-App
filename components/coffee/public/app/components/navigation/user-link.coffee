# @cjsx React.DOM
React = require 'react'
Router = require 'react-router'
injectTapEventPlugin = require 'react-tap-event-plugin'
injectTapEventPlugin()

UserLink = React.createClass
  mixins: [Router.Navigation]
  handleTap: ->
    @transitionTo('/user/' + @props.user._id)
  render: ->
    <div className='search-item' onTouchTap={@handleTap}>
      <img src='img/user-thumb.jpg'/>
      <ul className='item-details'>
        <li>{@props.user.firstName} {@props.user.surname}</li>
        <li>Joined {@props.user.timestamp}</li>
      </ul>
    </div>

module.exports = UserLink