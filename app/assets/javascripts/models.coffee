class User extends Backbone.Model
  url: "users"
  
  logged: ->
    @attributes.logged
  
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
        { engine: engine, pos: 99 }
        
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