class NewSiteView extends Backbone.View
  el: "#content"
  
  render: ->
    content = Utils.haml "#newSiteView", {}
    $(@el).html content 
    
    this

class SitesView extends Backbone.View

  el: "#content"

  constructor: ->
    # _.bindAll(this, 'render')
    # Sites.bind("all",   this.render, this)
    # Sites.bind("add",   this.addOne, this)
    Sites.bind "reset", this.addAll, this
  
  render: ->
    content = Utils.haml "#sitesView", {}
    $(@el).html content 
    # this.addAll()
    
    this
  
  addOne: (site) ->
    view = new SiteRow model: site
    content = view.render().el
    $(content).addClass "odd" if @odd
    @odd = !@odd
    this.$(".sitesList").append content
    
  addAll: ->     
    Sites.unbind "reset", this.addAll
    # console.log Sites.length 
    Sites.each (site) =>
      # console.log site.attributes.name
      this.addOne(site)
    Loading.loaded()
  