class RankeyView extends Backbone.View
  
  el: "#rankey"
  
  initialize: ->
    this.render()
    this.init_nav()
    this.initLoggedView()
      
  render: ->
    content = Utils.haml "#rankeyView", {}
    $(@el).html content
    
  showLogin: ->
    loginView = new LoginView()
    loginView.render()
    
  initLoggedView: ->
    loggedView = new LoggedView()
    loggedView.render()  
    
  init_nav: ->
    if g.cur_user.is_logged()
      navView = new NavView()
      navView.render()
      $("nav a").bind "click", ->
        Rankey.navigate "#{$(this).attr("data-url")}", true

  sites: ->
    @sitesView = new SitesView()
    Sites.fetch { error: this.handle_error }
    @sitesView.render()
    Loading.load()
    
  handle_error: (bview, err) ->
    error = JSON.parse(err.responseText)["message"]
    $(".msg").html("Error: #{error}")
    Rankey.navigate "login", true

  new_site: ->
    newSiteView = new NewSiteView()
    newSiteView.render()
    
  site: (site_id) ->  
    site = new Site({ id: site_id })
    @siteView = new SiteView( model: site )
    sites = new SitesList([site])
    site.fetch()
    Loading.load()
    