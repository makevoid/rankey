class SitesView extends Backbone.View

  el: ".sites"

  constructor: ->
    _.bindAll(this, 'render')
    Sites.bind("all",   this.render, this)
    Sites.bind("add",   this.addOne, this)
    Sites.bind("reset", this.addAll, this)
  
  render: ->
    content = Utils.haml "#sitesView", {}
    $(@el).html content 
    
    Sites.each (site) =>
      this.addOne(site)
    
    this
  
  addOne: (site) ->
    view = new SiteView model: site
    content = view.render().el
    Loading.loaded()
    this.$(".sitesList").append content
    
  addAll: ->  
    Sites.each this.addOne
    
  