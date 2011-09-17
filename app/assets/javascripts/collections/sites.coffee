class SitesList extends Backbone.Collection
  model: Site
  url: "/sites"
  
  # initialize:  ->
  # url: ->
  #   "sites.json"
  
  
  
window.Sites = new SitesList()