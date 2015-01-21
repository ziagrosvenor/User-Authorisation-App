# @cjsx React.DOM
React = require 'react/addons'

IconAlert = React.createClass
  render: ->
    this.transferPropsTo(
      <svg viewBox="0 0 100 100">
        <path  d="M52.484,34.72l9.83-9.833v-4.495c-6.09-3.49-13.113-5.54-20.639-5.54c-5.589,0-10.913,1.119-15.785,3.116    c1.583,0.039,2.962,0.261,4.674,0.173c0.936-0.047,2.571-0.257,3.46,0.051c0.776,0.269,1.444,1.487,2.219,1.862    c2.451,1.2,5.241,0.994,7.885,0.864c0.579-0.028,2.26-0.397,2.806-0.092c0.491,0.273,0.84,1.797,0.748,1.761    c1,0.381,2.971-0.29,3.803,0.252c0.926,0.599,1.063,2.694,0.777,3.613c-0.613,1.958-3.625,3.831-4.873,5.454    c-0.584,0.758-0.852,0.611-1.106,1.577c-0.136,0.532-0.047,1.202-0.167,1.718c0.071,0.059,0.444,0.085,0.538,0.11    c-0.416,1.099,0.892,1.451,1.019,2.6c1.598,0.862,1.691-1.406,3.325-0.408c0.809,0.498,1.426,2.586,1.498,3.503    c0.223,2.899-3.307,4.678-2.912,7.612c0.208,1.549,1.518,1.5,1.744,3.295c0.141,1.119-0.105,3.023-1.121,3.688    c-1.243,0.815-2.311-0.101-2.563-1.166c-0.1-0.415,0.277-1.319,0.157-1.899c-0.112-0.509-0.672-0.927-0.772-1.562    c-3.34-0.326-2.804,4.695-3.081,6.751c-0.257,1.897-0.825,2.608-1.98,3.995c-0.697,0.838-2.215,2.396-2.309,3.554    c-1.728,0.086-4.88,0.114-4.972-2.062c-0.02-0.446,0.844-1.391,0.966-1.976c0.247-1.127,0.033-1.7-0.387-2.714    c-0.477-1.156-1.039-2.123-1.948-2.916c-1.102-0.964-1.85-0.587-3.162-1.161c-2.606-1.14-7.14-5.435-7.94-8.155    c-0.408-1.385,0.155-3.221,0.006-4.666c-0.102-1.008-0.46-1.878-0.416-2.881c-2.095-0.021-2.264-1.133-2.492-2.936    c-0.232-1.803-0.426-2.311-1.318-3.884c-0.644-1.139-1.343-2.007-2.072-3.05c-0.627-0.895-0.503-2.121-1.147-2.979    c-0.175-0.232-0.401-0.417-0.646-0.588C5.483,32.945,0,44.084,0,56.528c0,20.546,14.88,37.576,34.443,41.009    c-1.43-3.049-0.798-6.897-0.99-10.472c-2.396,0.591-1.715-2.213-2.492-3.567c-0.931-1.625-1.074-1.959-1.306-4.043    c-0.299-2.695-0.754-3.861,2.251-4.484c0.151-1.301,1.544-1.234,2.547-1.52l-0.776-0.193c1.182,0.043,0.811-0.736,1.596-1.168    c0.958-0.525,2.266-0.754,3.303-1.303c1.628-0.865,2.276-1.199,4.421-0.644c3.242,0.833,5.076,3.188,7.215,5.778    c1.296,1.563,2.074,2.463,4.032,3.168c1.102,0.396,2.992,0.693,3.648,1.969c0.59,1.146-0.399,3.984-0.93,4.811    c-0.434,0.666-1.102,0.562-1.663,1.159c-0.608,0.654-1.01,1.459-1.595,2.188c-2.479,3.093-5.746,4.66-6.771,8.619    c20.525-2.59,36.414-20.074,36.414-41.309c0-8.008-2.302-15.457-6.214-21.808H52.484V34.72z"/>
        <path d="M94.82,0H74.014c-2.85,0-5.181,2.331-5.181,5.177v18.796l-7.188,7.193h12.369h2.018h2.392H94.82    c2.853,0,5.18-2.333,5.18-5.18V5.177C100,2.331,97.673,0,94.82,0z M86.002,24.106c-0.42,0.375-0.913,0.564-1.477,0.564    c-0.569,0-1.066-0.188-1.498-0.556c-0.424-0.371-0.637-0.886-0.637-1.553c0-0.581,0.207-1.074,0.611-1.481    c0.411-0.408,0.908-0.611,1.495-0.611c0.591,0,1.097,0.204,1.508,0.611c0.425,0.407,0.632,0.9,0.632,1.481    C86.639,23.218,86.426,23.731,86.002,24.106z M86.54,8.529l-0.606,6.925c-0.07,0.823-0.209,1.455-0.42,1.895    c-0.217,0.44-0.574,0.662-1.068,0.662c-0.506,0-0.859-0.212-1.055-0.64c-0.195-0.426-0.334-1.074-0.42-1.944l-0.449-6.73    c-0.084-1.31-0.129-2.251-0.129-2.824c0-0.776,0.207-1.381,0.61-1.819c0.411-0.434,0.945-0.652,1.608-0.652    c0.808,0,1.342,0.279,1.613,0.837c0.273,0.556,0.412,1.357,0.412,2.406C86.639,7.266,86.602,7.894,86.54,8.529z"/>
      </svg>
    )

module.exports = IconAlert