# @cjsx React.DOM
React = require 'react'
Router = require 'react-router'
Posts = require './components/post-list/app-posts'
PostEdit = require './components/post-edit/post-edit'
UserProfile = require './components/users/user-profile'
Template = require './components/app-template'

AJAXUtils = require './web-api-utils/ajax-utils'
SocketUtils = require './web-api-utils/websocket-utils'

AJAXUtils.getInitialData()
SocketUtils.listenForServerEvents()

Route = Router.Route
DefaultRoute = Router.DefaultRoute
RouteHandler = Router.RouteHandler
Link = Router.Link

APP = React.createClass
  render: ->
    <Template>
      <RouteHandler/>
    </Template>

routes =
  <Route handler={APP}>
    <DefaultRoute handler={Posts}/>
    <Route name='posts' path='/admin' handler={Posts}/>
    <Route name='edit' path='/edit-post/:id' handler={PostEdit}/>
    <Route name='user' path='/user/:id' handler={UserProfile}/>
  </Route>

Router.run routes, (Handler) ->
  React.render <Handler/>, document.getElementById('main')