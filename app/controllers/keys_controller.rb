class KeysController < ApplicationController
  
  before_filter :backbone_default_if_html
  
  layout nil
    
  def index
        
    site = Site.get params[:site_id]
    positions = Position.today.all(key: site.keys)
    # positions = Position.today.all(:pos.not => nil, :key => site.keys) if user.optimist?
    keys = build_keys site, positions
    keys = keys.map do |key|
      all_pos_nil = lambda do
        key[:positions].map{ |p| p[:pos].nil? || p[:pos] > Rankey::POS_OK }.uniq == [true]
      end
      unless key[:positions] == [] || all_pos_nil.call
        # puts "pos: ", key[:positions].inspect
        key 
      end
    end.compact if user.optimist?
    render json: keys
  end
  
  def history
    site = Site.get params[:site_id]
    # positions = Position.avg(:pos, key: site.keys, created_on: Position.history_days)#.map{ |a| a.attributes }
    days = []
    Position.history_days.each do |day|
      avg = Position.avg(:pos, key: site.keys, created_on: day )
      pos = Position.count(key: site.keys, created_on: day, :pos.lte => Rankey::POS_OK )
      days << { pos: pos, avg: avg.to_f, day: day }
    end    
    
    render json: days
  end
  
  def history_median

  end
  
  def history_show
    positions = Position.history.all(key_id: params[:id]).map{ |a| a.attributes }
    render json: positions
  end
  
  def keys
    json_keys = JSON.parse params[:keys]
    keys = Keys.new json_keys
    render json: keys.all
  end
  
  protected
  
  def build_keys(site, positions)
    site.keys.map do |key| 
      all_pos = positions.select{ |p| p.key_id == key.id }
      pos = all_pos.map do |p| 
        { pos: p.pos, engine: p.engine }
      end
      key.attributes.merge(positions: pos) 
    end
  end
  
end