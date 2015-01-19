React = require 'react'
AppStore = require '../stores/app-store'

StoreWatchMixin = (cb, users) ->
  getData: cb
  getUsers: users
  getInitialState: () ->
    data: []
  componentWillMount: () ->
    AppStore.addChangeListener(this._onChange)
  componentWillUnmount: () ->
    AppStore.removeChangeListener(this._onChange)       
  _onChange: () ->
    this.getData()
    if users
      @getUsers()
  componentDidMount: () ->
    this.getData()
    if users
      @getUsers()

module.exports = StoreWatchMixin