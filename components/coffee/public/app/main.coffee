# @cjsx React.DOM
React = require 'react/addons'
Router = require 'react-router'
ReactTouch = require 'react-touch'
FPSCounter = require 'react-touch/lib/environment/FPSCounter'
AppActions = require './actions/app-actions'
PostList = require './components/post-list/app-post-list'
PostAdd = require './components/post-list/app-post-add'
PostEdit = require './components/post-edit/post-edit'
AppSearch = require './components/search/app-search'
UserProfile = require './components/users/user-profile'
Homepage = require './components/homepage/homepage'
UserStats = require './components/stats/user-stats'
injectTapEventPlugin = require 'react-tap-event-plugin'
Template = require './components/app-template'
SimpleScroller =
  require 'react-touch/lib/interactions/simplescroller/SimpleScroller'

injectTapEventPlugin()
React.initializeTouchEvents(true)

AJAXUtils = require './web-api-utils/ajax-utils'
SocketUtils = require './web-api-utils/websocket-utils'

AJAXUtils.getInitialData()
SocketUtils.listenForServerEvents()

Route = Router.Route
DefaultRoute = Router.DefaultRoute
RouteHandler = Router.RouteHandler
Link = Router.Link

PostHandler = React.createClass
  render: ->
    <div>
      <PostList/>
      <RouteHandler/>
    </div>

AppStyle =
  bottom: 0
  left: 0
  overflow: 'hidden'
  position: 'fixed'
  right: 0
  top: 0

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
    <DefaultRoute handler={PostList}/>
    <Route name='homepage' path='/homepage' handler={Homepage}/>
    <Route name='posts' path='/posts' handler={PostHandler}>
      <Route name='form' path='/add' handler={PostAdd}/>
    </Route>
    <Route name='edit' path='/edit-post/:id' handler={PostEdit}/>
    <Route name='user' path='/user/:userId' handler={UserProfile}/>
    <Route name='search' path='/search' handler={AppSearch}/>
    <Route name='stats' path='/stats' handler={UserStats}/>
  </Route>

Router.run routes, (Handler, state) =>
  React.render <Handler/>, document.getElementById('main')
  if state.params.userId
    AppActions.clearUsers()
    AppActions.getOtherUser(state.params.userId)