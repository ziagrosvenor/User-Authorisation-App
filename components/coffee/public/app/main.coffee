# @cjsx React.DOM
APP = require './components/app'
AJAXUtils = require './web-api-utils/ajax-utils'
SocketUtils = require './web-api-utils/websocket-utils'
React = require 'react'

AJAXUtils.getCurrentUser()
AJAXUtils.getCurrentUserPosts()
SocketUtils.listenForServerEvents()

React.render <APP/>, document.getElementById('main')