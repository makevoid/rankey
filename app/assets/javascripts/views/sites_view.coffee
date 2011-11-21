class NewSiteView extends Backbone.View
  el: "#content"
  
  # events: {
  #   "submit form": "add_site"
  # }
  
  render: ->
    content = Utils.haml "#newSiteView", {}
    $(@el).html content 
    
    $(@el).find("form").bind "submit", (evt) => this.add_site(evt)
    
    this
    
  add_site: (evt) ->
    name = $(@el).find("input[name='name']").val()

    $.post "/sites.json", { name: name }, (data) ->
      unless data.error
        # $(@el).find("form").undelegate("submit", "add_site")
        Rankey.navigate "sites", true

        
    evt.preventDefault()

class SitesView extends Backbone.View

  el: "#content"
    
  constructor: ->
    # _.bindAll(this, 'render')
    # Sites.bind("all",   this.render, this)
    # Sites.bind("add",   this.addOne, this)
    Sites.bind "reset", this.addAll, this
  
  render: ->
    content = Utils.haml "#sitesView", {}
    $(@el).html content 
    $(".nav_right a").bind("click", ->
      Rankey.navigate "#{$(this).attr("data-url")}", true
    )
    # this.addAll()
    
    this
  
  addOne: (site) ->
    view = new SiteRow model: site
    content = view.render().el
    $(content).addClass "odd" if @odd
    @odd = !@odd
    this.$(".sitesList").append content
    
  addAll: ->     
    Sites.unbind "reset", this.addAll
    # console.log Sites.length 
    Sites.each (site) =>
      # console.log site.attributes.name
      this.addOne(site)
    Loading.loaded()
    