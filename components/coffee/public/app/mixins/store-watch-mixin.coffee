React = require 'react'
AppStore = require '../stores/app-store'

StoreWatchMixin = (cb, cbTwo) ->
  getInitialState: ->
    cb()

  componentWillMount: ->
    AppStore.addChangeListener(this._onChange)

  componentWillUnmount: ->
    AppStore.removeChangeListener(this._onChange)  
         
  _onChange: ->
    @setState(cb())
    if cbTwo
      @setState(cbTwo())

  componentDidMount: ->
    if cbTwo
      @setState(cbTwo())

module.exports = StoreWatchMixin