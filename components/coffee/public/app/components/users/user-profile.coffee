React = require 'react'
AppStore = require '../../stores/app-store'
UsersStore = require '../../stores/users-store'
StoreWatchMixin = require '../../mixins/store-watch-mixin'
_ = require 'lodash'

getAllUsers = ->
  users: UsersStore.getAllUsers()

UserProfile = React.createClass
  mixins: [new StoreWatchMixin(getAllUsers)]
  render: ->
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

    <div>
      {user}
    </div>

module.exports = UserProfile