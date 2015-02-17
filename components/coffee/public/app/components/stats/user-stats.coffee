# @cjsx React.DOM
React = require 'react/addons'
StoreWatchMixin = require '../../mixins/store-watch-mixin'
_ = require 'lodash'
AppActions = require '../../actions/app-actions'
PostStore = require('../../stores/app-store')
BarChart = require 'react-d3/barchart'
injectTapEventPlugin = require 'react-tap-event-plugin'
injectTapEventPlugin()

d3Chart = require './chart'

dataset = _.map _.range(14), (i) ->
  Math.random() * 50

getComponentState = ->
  PostStore.getPosts()

Chart = React.createClass
  getInitialState: ->
    posts: getComponentState()
  componentDidMount: ->
    node = @refs.chart.getDOMNode()

    d3Chart.create node,
      this.getChartState()

  componentDidUpdate: ->
    node = @refs.chart.getDOMNode()
    d3Chart.destroy(node);
    d3Chart.create node,
      this.getChartState()

  getChartState: ->
    likesData = @state.posts.map (post, i) ->
      if post.likes
        post.likes.length
      else
        0
    console.log likesData
    data: dataset

  componentWillUnmount: ->
    node = @refs.chart.getDOMNode()
    d3Chart.destroy(node);

  render: ->
    <div className='page-wrapper'>
      <h2>Likes on posts</h2>
      <div ref='chart' className='chartArea'/>
    </div>

module.exports = Chart