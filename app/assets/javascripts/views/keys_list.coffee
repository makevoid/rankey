class KeysListView extends Backbone.View

  el: ".keysListView"
  
  initialize: (opts) ->
    @collection = opts["collection"]
    @collection.bind("reset", this.render, this)
    
  render: ->
    content = Utils.haml "#keysListView", {}
    $(@el).html content
    @rows = []
    for key in @collection.models
      row = new KeyRow(model: key)
      @rows.push row 
      content = row.render().el
    
      $(content).addClass "odd" if @odd
      @odd = !@odd
      this.$(".keysList").append content    
  