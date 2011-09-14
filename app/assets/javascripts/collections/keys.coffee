class KeysList extends Backbone.Collection
  model: Key
  url: "/site/:id/keys"
  
window.Keys = new KeysList()  