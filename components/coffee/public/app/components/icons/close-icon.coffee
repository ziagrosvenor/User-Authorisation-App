React = require 'react'

IconClose = React.createClass
  render: ->
    this.transferPropsTo(
      <svg viewBox="0 0 100 100">
        <path d="M97.729,77.211L77.38,97.947L50.065,70.11L22.751,97.947L0.967,77.211L27.614,49.38L0.811,21.546
          l21.94-20.734l27.314,27.834L77.38,0.812l20.35,20.734L70.414,49.38L97.729,77.211z"/>
      </svg>
    )

module.exports = IconClose