class KeysController < ApplicationController
  
  layout nil
  
  def index
    site = Site.get params[:site_id]
    render json: site.keys
  end
  
end