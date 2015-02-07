# @cjsx React.DOM
React = require 'react'
AppActions = require '../actions/app-actions'
PostStore = require '../stores/app-store'
Posts = require '../components/post-list/app-posts'
PostEdit = require '../components/post-edit/post-edit'
UserProfile = require '../components/users/user-profile'
Template = require './app-template'
Router = require 'react-router-component'
StoreWatchMixin = require '../mixins/store-watch-mixin'

Locations = Router.Locations
Location = Router.Location

APP = React.createClass
  render: () ->
    <Template>
      <Locations>
        <Location path='/admin' handler={Posts}/>
        <Location path='/edit-post/:id' handler={PostEdit}/>
        <Location path='/user/:id' handler={UserProfile}/>
      </Locations>
    </Template>

module.exports = APP