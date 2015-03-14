# @cjsx React.DOM
React = require 'react'

logoStyle =
  width: "35px"
  height: "35px"
  position: "absolute"
  left: "45%"
  top: "8px"

UserNavigation = React.createClass
  render: ->
    <nav className='nav'>
      <div className='nav-wrapper'>
        <img style={logoStyle} src="./img/adwuk-logo.png"/>
        {@props.children}
      </div>
    </nav>
    
module.exports = UserNavigation