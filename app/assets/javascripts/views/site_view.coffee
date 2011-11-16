class SiteView extends Backbone.View

  el: "#content"
  
  initialize: ->    
    # console.log "what?"
    _.bindAll(this, 'render')
    this.model.bind("change", this.render)
    Sites.bind "all", this.render, this

    Keys = KeysBase.extend({
      url: "/sites/#{@model.attributes.id}/keys"
    })
    @siteKeys = new Keys()
    
    SiteStats = SiteStatsBase.extend({
      url: "/sites/#{@model.attributes.id}/keys/history"
    })
    @siteStats = new SiteStats()
    # Sites.bind("add",   this.addOne, this)
    # Sites.bind("reset", this.addAll, this)
  
  render: ->  
    Sites.unbind "all", this.render
    content = Utils.haml "#siteView", @model
    $(@el).html content 
    
    this.keys()    
    this.chart()
    this.bindTableBtns()
    Loading.loaded()
  
  keys: ->
    @keysView = new KeysListView({ collection: @siteKeys })
    @siteKeys.fetch()
    
  chart: ->
    @siteChart = new SiteChart({ collection: @siteStats })
    @siteStats.fetch()
    
  # tableBtns 

  bindTableBtns: ->
    this.$("#tableBtns .pos").bind("mouseover", {view: this}, this.showPositioneds)
    this.$("#tableBtns .pos").bind("click", {view: this}, this.showPositioneds)
    this.$("#tableBtns .pos").bind("mouseout", {view: this}, this.checkBlur)

  showPositioneds: (evt) ->  
    for keyRow in evt.data.view.keysView.rows
      keyRow.colorize(true)

  blurPositioneds: ->
    for row in @keysView.rows
      row.colorize()
    

  checkBlur: (evt) ->
    evt.data.view.blurPositioneds()
    
    