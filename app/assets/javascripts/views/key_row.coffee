# pos_texts = ["top", "good", "normal", "bad"]

class KeyRow extends Backbone.View
  tagName:  "tr"
  
  events: {
    "click div.pos": "open_search_engine"
  }
  
  initialize: ->
    # @pos_text = "good"
  
  render: ->
    $(this.el).html Utils.haml("#keyRow", this.model) 
    this.colorize()
    this
    
  open_search_engine: (evt) ->
    link = $(evt.target).data("link")
    # console.log "opening: ", link
    unless navigator.userAgent.match /Chrome/
      window.location = link
    else # chrome fix
      window.open link, "_engine"
    
  colorize: (only_pos=false, darkAmount=120) -> # TODO: refactor  
    idx = 0
    for td in $(@el).find("td div")
      pos = @model.attributes.positions[idx].attributes.pos
  
      if typeof(pos) != "number" 

        # pos != "?" || pos != "100+" || pos != null
        $(td).css("font-size", "0.8em");
      else
        this.apply_color td, idx, pos, only_pos, darkAmount
        
      idx++
      
  apply_color: (td, idx, pos, only_pos, darkAmount) ->

    pos_tresh = 100  
    val = if pos > pos_tresh
      -1
    else
      (((pos / pos_tresh ) - 1 ) * 2 + 1) / -1 # normalize value
    
    tresh = 70
    base = 255 - tresh
    red = base
    green = base
    if val < 0
      red -= parseInt(val*tresh)
      green += parseInt(val*tresh/2/4)
    else
      green += parseInt(val*tresh)
      red -= parseInt(val*tresh/2/3)
    
    # console.log "pos ", pos, "val ", val, "rg: #{red},#{green}"
    # $(td).css("background", "rgb(#{red},#{green},#{base})")

    # types = ["-webkit-", "-moz-", "-o-", ""]
    # types = ["-webkit-"]
    # for type in types
    
    color = "rgb(#{red},#{green},#{base})"
    color = $.xcolor.webround(color).getHex()
    # gradient = "-webkit-gradient(linear,left top,left bottom,from(#a4a4a4),to(#FFFFFF));"
      
      
    if only_pos 
      if pos < 30 # TODO: set Rankey::POS_OK
        color = $.xcolor.darken(color, 1, 40)
      else
        color = $.xcolor.lighten(color, 1, darkAmount*1.1)
          
    darkColor = $.xcolor.darken(color, 1, darkAmount)
    

    $(td).css({color: darkColor, borderColor: darkColor})
    $(td).css("background", color)
    # -webkit-linear-gradient(#ffffff, #bfc8cf)
        

  
  