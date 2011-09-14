class PositionsList extends Backbone.Collection
  model: Position
  url: "/site/:id/position"
  
window.Positions = new PositionsList()  