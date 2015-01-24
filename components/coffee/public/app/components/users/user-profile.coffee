React = require 'react'
AppStore = require '../../stores/app-store'
StoreWatchMixin = require '../../mixins/store-watch-mixin'
_ = require 'lodash'

getCurrentUser = ->
  currentUser: UserStore.getUser()

getAllUsers = ->
  otherUsers: UsersStore.getAllUsers()

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
            <h1>{user.firstName} {user.surname}</h1>
            <p>Joined in {new Date(user.timestamp).getFullYear()}</p>
            <ul>{activity}</ul>
          </div>
    else
      user = 'No user found'
    <div>
      {user}
    </div>

module.exports = UserProfile