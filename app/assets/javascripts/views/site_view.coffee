class SiteView extends Backbone.View
  tagName:  "tr"
  
  render: ->
    $(this.el).html Utils.haml("#siteView", this.model) 
    this