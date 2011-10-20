class LoadingView extends Backbone.View

  load: ->
    $(".loading").css({opacity: 1}).data("animating", "false").html "<div class='spinner'><div class='bg_bottom'></div><div class='bg_top'></div></div>"
    
  loaded: ->
    if $(".loading").data("animating") != "true"
      $(".loading").animate({ opacity: 0}, 1000, ->
        $(this).html("").data("animating", "true")
      )
  
  
g = window
g.Loading = new LoadingView()