class LoadingView extends Backbone.View

  load: ->
    $(".loading").html "loading"
    
  loaded: ->
    $(".loading").html ""
  
  
g = window
g.Loading = new LoadingView()