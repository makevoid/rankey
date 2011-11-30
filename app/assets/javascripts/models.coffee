class User extends Backbone.Model
  url: "users"
  
  initialize: ->
    @attrs = @attributes
    
  is_logged: ->
    @attributes.session

  
class Key extends Backbone.Model  
  initialize: ->
    positions = []
    engines = ["google", "yahoo", "bing"]
    
    for engine in engines
      pos = _(@attributes.positions).find (pos) ->
        pos.engine == engine
        
      position = if pos
        pos
      else
        { engine: engine, pos: "?" }
      position.key = this
      positions.push new Position(position)
      
    # console.log positions
    @attributes.positions = positions
  
  pos: (engine) -> # TODO: needed?, still not used anywhere
    _.detect(@positions, (pos) ->
      pos.attributes.engine == engine
    ).attributes.pos
  
class Position extends Backbone.Model
  initialize: ->
    @engine = new Engine({ name: @attributes.engine })    
    @attributes.link = this.engine_link()
    
  engine_link: ->
    key = @attributes.key.attributes.name
    # console.log "pos: ", @attributes.pos
    country = "it"
    start = Math.floor(@attributes.pos / 10)*10
    switch @attributes.engine
      when "google"
        "http://google.com/search?num=10&hl=#{country}&q=#{key}&start=#{start}"
      when "yahoo"
        "http://#{country}.search.yahoo.com/search?p=#{key}&n=10&b=#{start+1}"
      when "bing"       
        "http://#{country}.bing.com/search?q=#{key}&n=10&first=#{start+1}"

class Engine extends Backbone.Model
  icon: ->
    "/images/engines/#{@attributes.name}.png"
    
class Site extends Backbone.Model
  
  initialize: ->
    this.bind "change", this.debug
    @attributes.favicon = "http://#{@attributes.name}/favicon.ico"
    
  debug: ->
    @attributes.link = "http://#{@attributes.name}"
    

class SiteStat extends Backbone.Model