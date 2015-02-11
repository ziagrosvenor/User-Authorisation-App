# @cjsx React.DOM
React = require 'react/addons'
_ = require 'lodash'

AppActions = require '../../actions/app-actions'

IconAlert = require '../icons/alert-icon'

UserActivity = React.createClass
  getInitialState: ->
    dropdown: false

  handleClick: ->
    if @isMounted()
      @setState
        dropdown: !this.state.dropdown

    AppActions.activitySeen()

  render: ->
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

module.exports = UserActivity