# @cjsx React.DOM
React = require 'react/addons'

IconSearch = React.createClass
  render: ->
    this.transferPropsTo(
      <svg viewBox="0 0 100 100">
        <path d="M21.809,38.632c0-20.72,16.796-37.518,37.517-37.518c20.722,0,37.52,16.798,37.52,37.518
    c0,20.719-16.798,37.518-37.52,37.518c-6.857,0-13.287-1.842-18.818-5.055l-25.521,25.52c-7.535,0-13.643-6.107-13.643-13.643
    l25.52-25.518C23.649,51.92,21.809,45.492,21.809,38.632z M83.202,38.632c0-13.186-10.688-23.875-23.877-23.875
    c-13.185,0-23.875,10.689-23.875,23.875S46.14,62.508,59.325,62.508C72.514,62.508,83.202,51.818,83.202,38.632z"/>
      </svg>
    )

module.exports = IconSearch