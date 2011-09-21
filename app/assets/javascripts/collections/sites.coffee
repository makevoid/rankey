class SitesList extends Backbone.Collection
  model: Site
  url: "/sites"
  
window.Sites = new SitesList()



class SiteStatsBase extends Backbone.Collection
  model: SiteStat
