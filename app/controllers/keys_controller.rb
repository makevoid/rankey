class KeysController < ApplicationController
  
  before_filter :backbone_default_if_html
  skip_before_filter :verify_authenticity_token, only: :keys
  
  layout nil
    
  def index
    site = Site.get params[:site_id]
    
    # better solution (only today)
    # positions = Position.today.all(key: site.keys)
    
    # worse
    keys = site.keys
    positions = keys.map do |key| 
      Engine.all.map do |engine|
        Position.first(id_engine: engine.id, :key => key, :order => :created_on.desc)
      end
    end.flatten.compact

    keys = build_keys site, positions
    keys = optimist_keys keys if user.optimist?
    render json: keys
  end
  
  def history
    # site = Site.get params[:site_id]
    # # positions = Position.avg(:pos, key: site.keys, created_on: Position.history_days)#.map{ |a| a.attributes }
    # days = []
    # Position.history_days.each do |day|
    #   avg = Position.avg(:pos, key: site.keys, created_on: day )
    #   pos = Position.count(key: site.keys, created_on: day, :pos.lte => Rankey::POS_OK )
    #   days << { pos: pos, avg: avg.to_f, day: day }
    # end    
    # 
    # render json: days
    render json: []
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
  
  def optimist_keys(keys)
    keys.map do |key|
      all_pos_nil = lambda do
        key[:positions].map{ |p| p[:pos].nil? || p[:pos] > Rankey::POS_OK }.uniq == [true]
      end
      unless key[:positions] == [] || all_pos_nil.call
        # puts "pos: ", key[:positions].inspect
        key 
      end
    end.compact
  end
  
end