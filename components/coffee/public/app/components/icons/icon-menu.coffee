# @cjsx React.DOM
React = require 'react'

IconAlert = React.createClass
  render: ->
    this.transferPropsTo(
      <svg viewBox="0 0 100 100">
        <g>
          <rect y="0.25" width="99.504" height="19.901"/>
          <rect y="40.053" width="99.504" height="19.9"/>
          <rect y="79.854" width="99.504" height="19.898"/>
        </g>
      </svg>
    )

module.exports = IconAlert