class KeysController < ApplicationController
  
  before_filter :backbone_default_if_html
  
  layout nil
  
  def index
    site = Site.get params[:site_id]
    render json: site.keys
  end
  
end