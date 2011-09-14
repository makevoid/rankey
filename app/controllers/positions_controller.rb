class PositionsController < ApplicationController
  
  layout nil
  
  def index
    key = Key.get params[:key_id]
    render json: key.positions
  end
  
end