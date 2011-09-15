class SitesList extends Backbone.Collection
  model: Site
  url: "/sites"
  
  
window.Sites = new SitesList()