g = window

class RankeyRouter extends Backbone.Router
  routes: {
    '': "home",
    'sites/:site_id': 'site',
    'not_found': 'blank',
  }

  initialize: ->
    @main_view = new RankeyView()   
    
  home: ->
    @main_view.sites()

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
