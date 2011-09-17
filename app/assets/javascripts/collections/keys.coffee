class KeysList extends Backbone.Collection
  model: Key
  url: "/site/:id/keys.json"
  
window.Keys = new KeysList()  