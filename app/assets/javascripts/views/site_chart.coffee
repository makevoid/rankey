class SiteChart extends Backbone.View
  
  el: ".siteChart"

  initialize: (opts) ->
    @collection = opts["collection"]
    
    @collection.bind("reset", this.render, this)  
    
    
  render: ->
    console.log "rendered", this.collection
    pos = []
    avg = []
    idx = 0
    
    for model in @collection.models
      pos.push [idx, model.attributes.pos]
      avg.push [idx, model.attributes.avg]
      idx++

    $.plot(@el, [ pos, avg ]);

    this