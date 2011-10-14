class SiteRow extends Backbone.View
  tagName:  "tr"
  
  events: {
    "click td": "openSite"
  }
  
  render: ->
    $(this.el).html Utils.haml("#siteRow", this.model) 
    
    $(this.el).find(".favicon").bind("error", ->
      favicon_placeholder = "/favicon.ico"
      $(this).attr("src", favicon_placeholder)
    )
    this
    
  openSite: ->
    site_id = this.model.attributes.id
    Rankey.navigate "sites/#{site_id}", true
    
    # http://d.makevoid.com:3000