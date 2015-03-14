React = require 'react'
Router = require 'react-router'
_ = require 'lodash'
StoreWatchMixin = require '../../mixins/store-watch-mixin'
UserStore = require '../../stores/user-store'
AppActions = require '../../actions/app-actions'
{RaisedButton} = require 'material-ui'

getUserState = ->
  userName: UserStore.getFullName()

Homepage = React.createClass
  mixins: [new StoreWatchMixin(getUserState), Router.State]
  render: ->
    if @state.userName
      user = 
        <div>
          <h2 className="page-header">Welcome {@state.userName}!</h2>
        </div>
    else
      user = <div>loading...</div>

    <div className="page-wrapper">
      {user}
      <RaisedButton secondary={true}>Find Advice</RaisedButton>
      <RaisedButton secondary={true}>Get a mentor</RaisedButton>
      <RaisedButton secondary={true}>View Profile</RaisedButton>
    </div>

module.exports = Homepage