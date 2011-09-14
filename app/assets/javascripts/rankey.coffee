g = window

class RankeyApp extends Backbone.View
  initialize: ->
    @sitesView = new SitesView()
    Sites.fetch()

g.Rankey = new RankeyApp()