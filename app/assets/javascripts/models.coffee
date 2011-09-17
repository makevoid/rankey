class User extends Backbone.Model
  
class Key extends Backbone.Model  
  
class Position extends Backbone.Model
    
class Site extends Backbone.Model
  initialize: ->
    this.bind "change", this.debug
    
  debug: ->
    console.log "up", this