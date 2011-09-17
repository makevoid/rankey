class RankeyView extends Backbone.View
  
  el: "#rankey"
  
  initialize: ->
    this.render()
    this.initNav()
    
  render: ->
    content = Utils.haml "#rankeyView", {}
    $(@el).html content
  
  initNav: ->
    $("nav a").bind("click", ->
      Rankey.navigate "#{$(this).attr("data-url")}", true
    )

  sites: ->
    @sitesView = new SitesView()
    @sitesView.render()
    Loading.load()
    Sites.fetch()


  site: (site_id) ->  
    site = new Site({ id: site_id })
    @siteView = new SiteView( model: site )
    Loading.load()
    # site.fetch(site_id)
    sites = new SitesList([site])
    
    site.fetch()
    