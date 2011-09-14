class SitesView extends Backbone.View

  initialize: ->
    Sites.bind("all",   this.render, this)
    Sites.bind("add",   this.addOne, this)
    Sites.bind("reset", this.addAll, this)
  
  render: ->
    haml = Haml $("#sitesView").html()
    content = haml({})
    $(this.el).html content

    this
  
  addOne: ->
    view = new SiteView()
    content = view.render().el
    this.$(".sites").append content

    
  addAll: ->
    Sites.each this.addOne
    
  