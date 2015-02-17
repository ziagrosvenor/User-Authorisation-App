d3 = require 'd3'

d3Chart = {}

margin =
  top: 0
  right: 0
  bottom: 40
  left: 0

width = 300 - margin.left - margin.right
height = 200 - margin.top - margin.bottom

console.log width, height

d3Chart.create = (node, state) ->
  svg = d3.select(node).append('svg')
    .attr('class', 'barchart')
    .attr('width', (width + margin.left + margin.right))
    .attr('height', (height + margin.top + margin.bottom))

  this.update(node, state)

d3Chart.update = (node, state) ->
  scales = {}
  scales.xScale = d3.scale.ordinal()
    .domain(state.data)
    .rangeBands([0, width], 0.1, 0)

  scales.yScale = d3.scale.linear()
    .domain([0, d3.max(state.data)])
    .range([height, 0])

  @drawChart(node, scales, state.data)

d3Chart.drawChart = (node, scales, data) ->
  svg = d3.select(node).selectAll('.barchart')

  xAxis = d3.svg.axis()
    .scale(scales.xScale)
    .orient('bottom')
    .ticks(14)
    .innerTickSize(1)
    .outerTickSize(1)
    .tickPadding(20)
    .tickFormat (d, i) ->
      

  axis = svg.append('g')
    .attr('class', 'x axis')
    .attr('transform', 'translate(0 ' + height + ')')
    .call(xAxis)

  bars = svg.selectAll('rect')
    .data(data)
    .enter()
    .append('rect')
    .attr('class', 'bar')
    .attr('x', scales.xScale)
    .attr('width', scales.xScale.rangeBand())
    .attr('y', scales.yScale)
    .attr 'height', (d) ->
      height - scales.yScale(d)

  d3Chart.destroy = (node) ->
    # d3.select(node).selectAll('rect').remove()
    # d3.select(node).selectAll('g').remove()

module.exports = d3Chart