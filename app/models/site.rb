class Site
  include DataMapper::Resource
  
  property :id, Serial
  property :name, Text, length: 100, index: true
  property :label, String, length: 100
  property :keys_array, Text
  
  # property :label, String # TODO: label that appears in siteRow
  
  property :group_id, Integer, min: 1, index: true
  belongs_to :group
  
  has n, :keys, constraint: :destroy
  
  before :save do
    puts "TODO: validation: check if the name is in this format: 'abc.com'"
  end
  
  def update_keys(keys_array)
    new_keys = Keys.new(keys_array).all
    keys.all.each do |key|
      unless new_keys.include? key.name
        key.destroy
      end
    end
    
    new_keys.each do |key|
      if Key.first(name: key, site_id: id)
        # do nothing
      else
        keys.create(name: key)
      end
    end
    
    self.keys_src = keys_array
    self.save
  end
  
  def keys_src
    puts "keys: ", self.keys_array
    eval(self.keys_array)
  end
  
  def keys_src=(array)
    self.keys_array = array.to_s
  end
  
  def keys_pos_count
    Position.today.all(key: keys, fields: [:pos]).map do |p| 
      p.pos
    end.select{ |p| !p.nil? && p <= Rankey::POS_OK }.size
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