# @cjsx React.DOM
React = require 'react'
Router = require 'react-router'
injectTapEventPlugin = require 'react-tap-event-plugin'
injectTapEventPlugin()

# React.initializeTouchEvents(true)

EditPost = React.createClass
  mixins: [Router.Navigation, Router.State]
  handleTap: (e, item) ->
    @transitionTo('/edit-post/' + @props.id)
  render: ->
    <button onTouchTap={@handleTap} className='btn'>
      Edit
    </button>

module.exports = EditPost