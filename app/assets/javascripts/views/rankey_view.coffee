class RankeyView extends Backbone.View
  
  el: "#rankey"
  
  initialize: ->
    this.render()
    this.initNav()
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
    
  initNav: ->
    if g.cur_user.logged
      navView = new NavView()
      navView.render()
      $("nav a").bind("click", ->
        Rankey.navigate "#{$(this).attr("data-url")}", true
      )

  sites: ->
    @sitesView = new SitesView()
    Sites.fetch()
    @sitesView.render()
    Loading.load()

  new_site: ->
    newSiteView = new NewSiteView()
    newSiteView.render()
    
  site: (site_id) ->  
    site = new Site({ id: site_id })
    @siteView = new SiteView( model: site )
    sites = new SitesList([site])
    site.fetch()
    Loading.load()
    