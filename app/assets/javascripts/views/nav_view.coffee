class NavView extends Backbone.View
  
  render: ->
    content = Utils.haml "#navView", {}
    $("#nav").html content