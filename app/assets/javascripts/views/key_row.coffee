# pos_texts = ["top", "good", "normal", "bad"]

class KeyRow extends Backbone.View
  tagName:  "tr"
  
  initialize: ->
    # @pos_text = "good"
  
  render: ->
    $(this.el).html Utils.haml("#keyRow", this.model) 
    this.colorize()
    this
    
  colorize: (only_pos=false, darkAmount=120) -> # TODO: refactor  
    idx = 0
    for td in $(this.el).find("td div")
      pos = this.model.positions[idx].attributes.pos
            
      pos_tresh = 100  
      val = if pos > pos_tresh
        -1
      else
        (((pos / pos_tresh ) - 1 ) * 2 + 1) / -1 # normalize value
      
      idx++
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

      types = ["-webkit", "-moz", "-o", ""]
      for type in types
        color = "rgb(#{red},#{green},#{base})"
        gradient = "#{type}-linear-gradient(#ffffff, #{color} )"
        
        
        if only_pos 
          if pos < 30 # TODO: set Rankey::POS_OK
            color = $.xcolor.darken(color, 1, 40)
          else
            color = $.xcolor.lighten(color, 1, darkAmount*1.1)
              
        darkColor = $.xcolor.darken(color, 1, darkAmount)
      
        $(td).css({background: gradient, color: darkColor, borderColor: darkColor})
  
      # -webkit-linear-gradient(#ffffff, #bfc8cf)

  
  