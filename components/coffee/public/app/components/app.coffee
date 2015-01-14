# @cjsx React.DOM
React = require 'react'
AppActions = require '../actions/app-actions'
Posts = require '../components/post-list/app-posts'
PostEdit = require '../components/post-edit/post-edit'
Template = require './app-template'
Router = require 'react-router-component'

Locations = Router.Locations
Location = Router.Location

APP = React.createClass
  handleClick: () ->
    AppActions.addPost('This is a post')
  render: () ->
    <Template>
      <Locations>
        <Location path='/admin' handler={Posts}/>
        <Location path='/edit-post/:id' handler={PostEdit}/>
      </Locations>
    </Template>

module.exports = APP