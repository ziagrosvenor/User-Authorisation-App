React = require 'react'
AppStore = require '../../stores/app-store'
StoreWatchMixin = require '../../mixins/store-watch-mixin'
_ = require 'lodash'

getUser = ->
  AppStore.getUser().then (data) =>
    for obj in data
      user = obj
    if @isMounted()
      @setState
        data: user

getAllUsers = ->
  AppStore.getUsers().then (users) =>
    if @isMounted()
      @setState
        users: users

UserProfile = React.createClass
  mixins: [new StoreWatchMixin(getUser, getAllUsers)]
  render: ->
    if @state.users and @props.id
      users = @state.users
      id = @props.id
      user = @state.users.map (user, i) ->
        if id == user._id
          activity = _.map user.activity, (item, i) ->
            <li key={i}>{item.type} on {new Date(item.timestamp).getHours()}</li>

          <div>
            <h1> {user.firstName} {user.surname} </h1>
            <p>Joined in {new Date(user.timestamp).getFullYear()}</p>
            <ul>{activity}</ul>
          </div>
    else
      user = 'No user found'
    <div>
      {user}
    </div>

module.exports = UserProfile