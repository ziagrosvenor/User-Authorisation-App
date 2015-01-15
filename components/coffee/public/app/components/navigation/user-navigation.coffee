# @cjsx React.DOM
React = require 'react/addons'
AppActions = require '../../actions/app-actions'
AppStore = require('../../stores/app-store')
Link = require('react-router-component').Link

UserOptions = React.createClass
  handleClick: ->
    this.props.onOptionsClick()
  render: () ->
    dropdownClasses = React.addons.classSet
      'is-hidden': this.props.dropdown == false
    btnClasses = React.addons.classSet
      'btn': true
      'btn-notify': this.props.status == 1
    <div className='userOptions'>
      <button className={btnClasses} onClick={this.handleClick}>Hi there, {@props.name}</button>
      <ul className={dropdownClasses}>
        <li> Messages: {this.props.messages} </li>
        <li> Logout </li>
      </ul>
    </div>

UserNavigation = React.createClass
  getInitialState: ->
    name: 'User'
    messages: 3
    status: 1
    dropdown: false
  handleOptionsClick: ->
    if this.isMounted()
      this.setState
        status: 0
        dropdown: !this.state.dropdown
  render: () ->
    <nav className='nav'>
      <div className='page-wrapper'>
        <UserOptions 
          name={@props.user.firstName}
          messages={this.state.messages}
          status={this.state.status}
          dropdown={this.state.dropdown}
          onOptionsClick={this.handleOptionsClick}
        />
      </div>
    </nav>

module.exports = UserNavigation