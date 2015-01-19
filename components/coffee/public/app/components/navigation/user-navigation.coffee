# @cjsx React.DOM
React = require 'react/addons'
AppActions = require '../../actions/app-actions'
AppStore = require('../../stores/app-store')
Link = require('react-router-component').Link
_ = require 'lodash'

UserOptions = React.createClass
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
      'is-active': this.state.dropdown == true
      'is-hidden': this.state.dropdown == false
    btnClasses = React.addons.classSet
      'btn': true
      'btn-notify': status == 1
    if @props.activity
      activity = _.map @props.activity, (item, i) ->
        if i < 5
          <li key={i}> {item.type} </li>

    <div>
      <button className={btnClasses} onClick={this.handleClick}>Activity</button>
      <ul className={dropdownClasses}>
        {activity}
        <li> Logout </li>
      </ul>
    </div>

UserNavigation = React.createClass
  render: () ->
    <nav className='nav'>
      <div className='page-wrapper'>
        <UserOptions 
          name={@props.user.firstName}
          activity={@props.user.activity}
        />
      </div>
    </nav>

module.exports = UserNavigation