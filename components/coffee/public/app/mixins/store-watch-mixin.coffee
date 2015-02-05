React = require 'react'
AppStore = require '../stores/app-store'

StoreWatchMixin = (cb) ->
  getInitialState: ->
    cb()

  componentWillMount: ->
    AppStore.addChangeListener(this._onChange)

  componentWillUnmount: ->
    AppStore.removeChangeListener(this._onChange)
         
  _onChange: ->
    @setState(cb())

module.exports = StoreWatchMixin