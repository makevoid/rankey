g = window

class RankeyApp extends Backbone.View
  
  el: "#rankey"
  
  initialize: ->
    @sitesView = new SitesView()
    @sitesView.render()
    this.render()
    
    Loading.load()
    Sites.fetch()
    
  render: ->
    content = Utils.haml "#rankeyView", {}
    $(@el).html content
  
    
$( ->
  g.Rankey = new RankeyApp()      
)

