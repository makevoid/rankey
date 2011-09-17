class PositionsList extends Backbone.Collection
  model: Position
  url: "/site/:id/positions.json"
  
window.Positions = new PositionsList()  