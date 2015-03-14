React = require 'react'
Router = require 'react-router'
UserStore = require('../stores/user-store')
StoreWatchMixin = require '../mixins/store-watch-mixin'
Nav = require './navigation/user-navigation'
Notifications = require './navigation/user-activity'
SearchUsers = require './navigation/search-users'
MenuIcon = require './icons/icon-menu'
SearchIcon = require './icons/search-icon'
LeftNavContainer = require 'react-touch/lib/interactions/leftnav/LeftNavContainer'
TouchableArea = require 'react-touch/lib/primitives/TouchableArea'
App = require('react-touch/lib/primitives/App')

React.initializeTouchEvents(true)
injectTapEventPlugin = require 'react-tap-event-plugin'
injectTapEventPlugin()

SIDEBAR_WIDTH = 192
TOPBAR_HEIGHT = 52

SideNavItem = React.createClass
  mixins: [Router.Navigation, Router.State]
  
  handleTap: ->
    @transitionTo(@props.href)

  render: ->
    <div className='sideNavItem' onTouchTap={@handleTap}>
      {@props.children}
    </div>

getComponentState = ->
  currentUser: UserStore.getUser() 

Layout = React.createClass
  mixins: [new StoreWatchMixin(getComponentState)]
  render: ->
    button = <MenuIcon className='iconNav Layout-hamburger'/>

    topContent =
      <Nav>
        <Notifications activity={@state.currentUser.activity}/>
      </Nav>

    sideContent =
        <div className='Layout-nav'>
          <SideNavItem href='/search'>
            <SearchIcon className='iconSideNav'/>
            <span>Find People</span>
          </SideNavItem>
          <SideNavItem href='/homepage'>
            <MenuIcon className='iconSideNav'/>
            <span>Home Page</span>
          </SideNavItem>
          <SideNavItem href='/posts'>
            <MenuIcon className='iconSideNav'/>
            <span>Job History</span>
          </SideNavItem>
          <SideNavItem href='/stats'>
            <MenuIcon
              className='iconSideNav'
            />
            <span>Stats</span>
          </SideNavItem>
        </div>

    @transferPropsTo (
      <App>
        <LeftNavContainer
          ref='LeftNavContainer'
          button={button}
          topContent={topContent}
          sideContent={sideContent}
          topHeight={TOPBAR_HEIGHT}
          sideWidth={SIDEBAR_WIDTH}>
          <div className='Layout-content'>
            {this.props.children}
          </div>
        </LeftNavContainer>
      </App>
    )

module.exports = Layout