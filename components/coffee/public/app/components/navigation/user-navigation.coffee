# @cjsx React.DOM
React = require 'react'

UserNavigation = React.createClass
  render: ->
    <nav className='nav'>
      <div className='nav-wrapper'>
        {@props.children}
      </div>
    </nav>
    
module.exports = UserNavigation