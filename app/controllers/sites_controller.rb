class SitesController < ApplicationController
  
  layout nil
  
  def index
    data = Site.all.map{ |s| s.attributes }
    render json: data
  end
  
end