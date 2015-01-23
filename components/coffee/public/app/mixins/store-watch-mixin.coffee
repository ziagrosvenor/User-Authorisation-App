React = require 'react'
AppStore = require '../stores/app-store'

StoreWatchMixin = (cb, users) ->
  getUsers: users
  getInitialState: () ->
    cb()
  componentWillMount: () ->
    AppStore.addChangeListener(this._onChange)
  componentWillUnmount: () ->
    AppStore.removeChangeListener(this._onChange)       
  _onChange: () ->
    @setState(cb())
    if users
      @getUsers()
  componentDidMount: () ->
    if users
      @getUsers()

module.exports = StoreWatchMixin