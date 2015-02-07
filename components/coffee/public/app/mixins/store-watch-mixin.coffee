React = require 'react'
PostStore = require '../stores/app-store'

StoreWatchMixin = (cb) ->
  getInitialState: ->
    cb()

  componentWillMount: ->
    PostStore.addChangeListener(this._onChange)

  componentWillUnmount: ->
    PostStore.removeChangeListener(this._onChange)
         
  _onChange: ->
    @setState(cb())

module.exports = StoreWatchMixin