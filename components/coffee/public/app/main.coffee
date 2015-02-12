# @cjsx React.DOM
React = require 'react/addons'
Router = require 'react-router'
ReactTouch = require 'react-touch'
FPSCounter = require 'react-touch/lib/environment/FPSCounter'
AppActions = require './actions/app-actions'
Posts = require './components/post-list/app-posts'
PostEdit = require './components/post-edit/post-edit'
AppSearch = require './components/search/app-search'
UserProfile = require './components/users/user-profile'
injectTapEventPlugin = require 'react-tap-event-plugin'
Template = require './components/app-template'
SimpleScroller =
  require 'react-touch/lib/interactions/simplescroller/SimpleScroller'


AJAXUtils = require './web-api-utils/ajax-utils'
SocketUtils = require './web-api-utils/websocket-utils'

AJAXUtils.getInitialData()
SocketUtils.listenForServerEvents()


Route = Router.Route
DefaultRoute = Router.DefaultRoute
RouteHandler = Router.RouteHandler
Link = Router.Link

AppStyle =
  bottom: 0
  left: 0
  overflow: 'hidden'
  position: 'fixed'
  right: 0
  top: 0

injectTapEventPlugin()

React.initializeTouchEvents(true)

APP = React.createClass
  handleTouch: (e) ->
    e.preventDefault()
  render: ->
    <Template>
      <SimpleScroller options={{scrollingX: false}}>
        <RouteHandler/>
      </SimpleScroller>
    </Template>


FPSCounter.start()

routes =
  <Route handler={APP}>
    <DefaultRoute handler={Posts}/>
    <Route name='posts' path='/posts' handler={Posts}/>
    <Route name='edit' path='/edit-post/:id' handler={PostEdit}/>
    <Route name='user' path='/user/:userId' handler={UserProfile}/>
    <Route name='search' path='/search' handler={AppSearch}/>
  </Route>

Router.run routes, (Handler, state) =>
  React.render <Handler/>, document.getElementById('main')
  if state.params.userId
    AppActions.clearUsers()
    AppActions.getOtherUser(state.params.userId)