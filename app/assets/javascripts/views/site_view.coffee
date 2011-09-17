class SiteView extends Backbone.View

  el: "#content"
  
  initialize: ->
    console.log "asd"
    _.bindAll(this, 'render')
    this.model.bind("change", this.render)
    Sites.bind("all",   this.render, this)    # 
        # Sites.bind("add",   this.addOne, this)
        # Sites.bind("reset", this.addAll, this)
  
  render: ->
    console.log "asd222", this.model
    content = Utils.haml "#siteView", this.model
    $(@el).html content 
  