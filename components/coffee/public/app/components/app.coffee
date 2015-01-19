# @cjsx React.DOM
React = require 'react'
AppActions = require '../actions/app-actions'
AppStore = require '../stores/app-store'
Posts = require '../components/post-list/app-posts'
PostEdit = require '../components/post-edit/post-edit'
UserProfile = require '../components/users/user-profile'
Template = require './app-template'
Router = require 'react-router-component'
StoreWatchMixin = require '../mixins/store-watch-mixin'

Locations = Router.Locations
Location = Router.Location

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

APP = React.createClass
  mixins: [new StoreWatchMixin(getUser, getAllUsers)]
  render: () ->
    <Template user={@state.data} users={@state.users}>
      <Locations users={@state.users}>
        <Location path='/admin' handler={Posts}/>
        <Location path='/edit-post/:id' handler={PostEdit}/>
        <Location path='/user/:id' handler={UserProfile}/>
      </Locations>
    </Template>

module.exports = APP