g = window

class RankeyRouter extends Backbone.Router
  routes: {
    '': "sites",
    'login': "login",
    'logout': "logout",
    'sites': 'sites',
    'sites/:site_id': 'site',
    'logout': 'logout',
    'not_found': 'blank',
  }

  initialize: ->
    @cur_user = new User()
    g.cur_user = @cur_user
    @main_view = new RankeyView() 
    this.sites()
    
  sites: ->
    return this.login() unless @cur_user.logged
    @main_view.sites()

  login: ->
    @main_view.showLogin()

  logout: ->
    console.log "logging out"
    g.userData = {}
    g.cur_user.set(session: null, name: null, email: null, logged: false)
    Rankey.navigate "login", true
    # ...

  site: (site_id) ->
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
