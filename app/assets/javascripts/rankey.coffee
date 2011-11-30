g = window

class RankeyRouter extends Backbone.Router
  routes: {
    '': "sites",
    'login': "login",
    'logout': "logout",
    'sites/new': 'new_site',
    'sites': 'sites',
    'sites/:site_id': 'site',
    'logout': 'logout',
    'not_found': 'blank',
  }

  initialize: ->
    this.auth()
    @main_view = new RankeyView()
  
  # authentication 
  
  auth: ->
    user_data  = JSON.parse g.userData
    @cur_user  = new User user_data
    g.cur_user = @cur_user
    @is_logged = @cur_user.is_logged()
    
  sites: ->
    return this.require_login() unless @is_logged
    @main_view.sites()

  path: ->
    document.location.pathname
    
  require_login: ->
    # console.log(this.path() == "/")
    $(".msg").html "Login first please!" unless this.path() == "/"
    g.Rankey.navigate "login", true

  login: ->
    @main_view.showLogin()

  logout: ->
    console.log "logging out"
    g.userData = {}
    g.cur_user.set(session: null, name: null, email: null, logged: false)
    data = { session: @cur_user.attrs.session }
    req = $.ajax { url: "/sessions.json", type: "delete", data: data }
    Loading.load()
    req.done (data) =>
      console.log data
      Loading.loaded()      
    Rankey.navigate "login", true
                             
  new_site: (site_id) ->     
    return this.require_login() unless @is_logged
    @main_view.new_site()
    
  site: (site_id) ->       
    return this.require_login() unless @is_logged
    @main_view.site(site_id)

  blank: ->
    content = "
.page\n
  %h2 Notice\n
  .cont\n
    %p Section not found\n
    %p\n 
      Go back to \n 
      %a.sites_btn{ href: 'javascript:void(0)' } Sites\n
  .foot\n
    "
    haml = Haml content
    $("#content").html haml({})
    $(".sites_btn").bind("click", ->
      Rankey.navigate "", true
    ) 

$( ->
  g.Rankey = new RankeyRouter()
  
  Backbone.history.start({
      pushState: true
  });

)
