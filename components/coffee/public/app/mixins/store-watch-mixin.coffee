React = require 'react'
AppStore = require '../stores/app-store'

StoreWatchMixin = (cb) ->
  getData: cb
  getInitialState: () ->
    data: []
  componentWillMount: () ->
    AppStore.addChangeListener(this._onChange)
  componentWillUnmount: () ->
    AppStore.removeChangeListener(this._onChange)       
  _onChange: () ->
    this.getData()
  componentDidMount: () ->
    this.getData()

module.exports = StoreWatchMixin