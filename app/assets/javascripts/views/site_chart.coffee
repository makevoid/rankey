class SiteChart extends Backbone.View
  
  ele: ".siteChart"

  initialize: (opts) ->
    @collection = opts["collection"]
    @el = @ele # FIXME: why do I need this?
    @collection.bind("reset", this.render, this)  
    
  render: ->  
    
    do_resize = (elem) ->
      width = $(".cont").width() /2.12# - 500
      width = Math.max Math.min( width, 400), 250
      height = window.sshot_ratio * width
      elem.css({ width: width, height: height})
    
    resize_sshot = ->
      elem = $(".sshot")
      if elem.length != 0
        if elem.attr("data-resized") == "resized"
        else
          window.sshot_ratio = elem.width() / elem.height() / 2
          elem.attr("data-resized", "resized")
      do_resize(elem)

    draw_chart = =>
      pos = []
      avg = []
      idx = 0
    
      for model in @collection.models
        pos.push [idx, model.attributes.pos]
        avg.push [idx, model.attributes.avg]
        idx++
      
      width = width = $(".cont").width() /2.12
      width = Math.max Math.min( width, 400), 250
      if (width == 400)
        width = $(".cont").width() - 450
      height = window.sshot_ratio * width
      if (width > 400)
        height = Math.min( width, window.sshot_ratio*400)
      
      $(@el).css({ width: width, height: height})
      $.plot(@el, [ pos, avg ])


    # main
    resize_sshot()
    draw_chart()
    
    $(window).unbind("resize")
    $(window).bind("resize", ->
      resize_sshot()
      draw_chart()
    )
    
    # console.log "rendered", this.collection

    this