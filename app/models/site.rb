class Site
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String, length: 100, index: true
  
  has n, :keys
  
  
  def keys_pos_count
    Position.today.all(key: keys, fields: [:pos]).map do |p| 
      p.pos
    end.select{ |p| p <= Rankey::POS_OK }.size
  end
  
  def keys_count
    @keys_count ||= Position.count(created_on: Date.today, key: keys)
  end
  
  def list_attrs
    attributes.merge(
      keys_count: keys_count,
      keys_pos_count: keys_pos_count
    )
  end
  
  def show_attrs
    list_attrs.merge(
      image: image
    )
  end
  
  def image
    hshot = HShot.new
    hshot.get "http://#{name}"
  end
end