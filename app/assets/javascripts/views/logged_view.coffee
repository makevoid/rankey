class LoggedView extends Backbone.View
  
  events: {
    "click #login a.logout": "logout"
  }
  
  initialize: ->
    cur_user.bind("change", this.render, this)
  
  render: ->
    cont = Utils.haml "#loggedView", cur_user
    $(@el).html(cont)
    $("#login").html(@el)
    
  logout: ->
    Rankey.navigate "logout", true