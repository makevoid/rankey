class SitesController < ApplicationController
  
  before_filter :backbone_default_if_html
  
  layout nil
  
  def index
    data = Site.all.map{ |s| s.list_attrs }
    render json: data
  end
  
  def show
    site = Site.get(params[:site_id])
    data = site ? site.show_attrs : not_found(:site)
    render json: data
  end
  
  def image
    site = Site.get(params[:site_id])
    render json: get_resp(site, :site){ |obj| obj.image }
  end
  
  protected
  
  def get_resp(obj, name, &block)
    if obj
      block.call(obj)
    else
      not_found name
    end
  end
  
end