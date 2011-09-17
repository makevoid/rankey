g = window

class RankeyRouter extends Backbone.Router
  routes: {
    '': "home",
    'sites/:site_id': 'site',
    'blank': 'blank',
  }

  initialize: ->
    @main_view = new RankeyView()   
    
  home: ->
    @main_view.sites()

  site: (site_id) ->
    @main_view.site(site_id)

  blank: ->
    $("#content").html("Page not found")

$( ->
  g.Rankey = new RankeyRouter()
  
  Backbone.history.start({
      pushState: true
  });
)
