class SitesController < ApplicationController
  
  before_filter :backbone_default_if_html
  
  layout nil
  
  def index
    data = Site.all.map{ |s| s.attributes }
    render json: data
  end
  
  def show
    site = Site.get(params[:site_id])
    data = site.nil? ? { error: { type: "not_found", message: "Site not found"} } : site.attributes
    render json: data
  end
  
end