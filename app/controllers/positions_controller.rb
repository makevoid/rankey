class PositionsController < ApplicationController
  
  before_filter :backbone_default_if_html
  
  layout nil
  
  def index
    key = Key.get params[:key_id]
    render json: key.positions
  end
  
end