# @cjsx React.DOM
React = require 'react'

UserNavigation = React.createClass
  render: ->
    <nav className='nav'>
      <div className='page-wrapper'>
        {@props.children}
      </div>
    </nav>
    
module.exports = UserNavigation