class SitesController < ApplicationController
  
  before_filter :backbone_default_if_html
  
  layout nil
  
  def index
    data = Site.all.map{ |s| s.list_attrs }
    render json: data
  end
  
  def show
    data = site ? site.show_attrs : not_found(:site)
    render json: data
  end
  
  def image
    render json: get_resp(site, :site){ |obj| obj.image }
  end
  
  def create
    new_site = Site.create name: params[:name]
    data = new_site ? new_site.list_attrs : model_error(:create, :site)
    render json: data
  end
  
  def destroy
    data = site && site.destroy ? { success: "Site deleted" } : { error: "Error deleting the site" }
    render json: data
  end
  
  def keys
    keys = site && site.keys_src
    data = keys ? keys : { error: "Error getting site keys for site: #{site}" }
    render json: data
  end
  
  def update_keys
    keys = JSON.parse params[:keys]
    puts "keys:"
    p keys
    data = site && site.update_keys(keys) ?  { success: "Site keys updated (#{site.keys.count})" } : { error: "Error updating the site" }
    render json: data
  end
  
  protected
  
  def site 
    Site.get params[:site_id]
  end
  
  def get_resp(obj, name, &block)
    if obj
      block.call(obj)
    else
      not_found name
    end
  end
  
end