g = window

class RankeyRouter extends Backbone.Router
  routes: {
    '': "home",
    'login': "login",
    'sites/:site_id': 'site',
    'not_found': 'blank',
  }

  initialize: ->
    @main_view = new RankeyView() 
    this.check_login()
    
  
  check_login: ->    
    @cur_user = new User()
    if g.userData && g.userData.session
      @cur_user.set({ session: g.userData.session })
      this.go_home()
    else
      this.login()
      # TODO: get user from page variable
      # @cur_user.fetch()

    
  
  home: ->
    if @cur_user.is_synced 
      this.go_home()
    else
      @cur_user.bind("change", this.go_home)
  
  go_home: ->
    if @cur_user.is_logged
      @main_view.sites()
    else
      this.login()

  login: ->
    @main_view.showLogin()

  site: (site_id) ->
    @main_view.site(site_id)

  is_logged_in = ->
    false


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
