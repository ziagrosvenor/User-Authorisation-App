# @cjsx React.DOM
React = require 'react/addons'
_ = require 'lodash'

AppActions = require '../../actions/app-actions'
AppStore = require('../../stores/app-store')

Link = require('react-router-component').Link
Search = require './search-users'
IconSearch = require '../icons/search-icon'
IconAlert = require '../icons/alert-icon'

UserActivity = React.createClass
  getInitialState: ->
    dropdown: false
  handleClick: ->
    AppActions.activitySeen()
    if @isMounted()
      @setState
        dropdown: !this.state.dropdown
  render: () ->
    unseen = _.find(@props.activity, seen: false)
    if typeof unseen == 'object'
      status = 1
    dropdownClasses = React.addons.classSet
      'dropdown': true
      'is-active': this.state.dropdown == true
      'is-hidden': this.state.dropdown == false
    iconClasses = React.addons.classSet
      'iconNav': true
      'isAlert': status == 1
    if @props.activity
      activity = _.map @props.activity, (item, i) ->
        if i < 5
          <li key={i}> {item.type} </li>

    <div>
      <IconAlert className={iconClasses} onClick={this.handleClick}/>
      <ul className={dropdownClasses}>
        {activity}
      </ul>
    </div>

UserSearch = React.createClass
  getInitialState: ->
    dropdown: false
  handleClick: ->
    if @isMounted()
      @setState
        dropdown: !this.state.dropdown
  render: () ->
    dropdownClasses = React.addons.classSet
      'search': true
      'is-active': this.state.dropdown == true
      'is-hidden': this.state.dropdown == false
    iconClasses = React.addons.classSet
      'iconNav': true
    <div>
      <IconSearch className={iconClasses} onClick={this.handleClick}/>
      <div className={dropdownClasses}>
        <Search users={@props.users} onIconClick={@handleClick}/>
      </div>
    </div>

UserNavigation = React.createClass
  render: () ->
    <nav className='nav'>
      <div className='page-wrapper'>
        <UserActivity 
          name={@props.user.firstName}
          activity={@props.user.activity}
        />
        <UserSearch users={@props.users}/>
      </div>
    </nav>
    
module.exports = UserNavigation