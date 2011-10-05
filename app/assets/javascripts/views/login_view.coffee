class LoginView extends Backbone.View
  
  
  events: {
    "submit form.login": "login"
  }
  
  login: (evt) ->
    form = "form.login"
    username = $("#{form} input[name=username]").val()
    password = $("#{form} input[name=password]").val()
    remember_me = true
    # console.log "loggin' in with: ", username, password
    data = { username: username, password: password, remember_me: remember_me }
    evt.preventDefault()
    self = this
    $.post("/sessions.json", data, (data) -> 
    
      if data.error
        self.show_message "Wrong Email or password, please recheck!"
      else
        self.show_message "logged in: #{data}"
      console.log data
    )
  
  # TODO move in UI
  show_message: (msg) ->
    this.$(".msg").html msg
    
    
  render: ->
    content = Utils.haml "#loginView", {}
    $(@el).html content
    $("#content").html @el
    this
