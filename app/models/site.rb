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
    eval(self.keys_array)
  end

  def keys_src=(array)
    self.keys_array = array.to_s
  end

  KEY_POS_COUNTS = {}
  KEY_COUNTS = {}

  Thread.new {
    loop do
      Site::KEY_POS_COUNTS.clear
      Site::KEY_COUNTS.clear
      sleep 3600 # 1h
    end
  }

  def keys_pos_count
    return KEY_POS_COUNTS[id] if KEY_POS_COUNTS[id]
    all = Position.all(key: keys, fields: [:pos, :key_id, :id_engine]).map do |p|
      { pos: p.pos,
        key_id: p.key_id,
        engine_id: p.id_engine }
    end.select{ |p| p && p[:pos] && p[:pos] <= Rankey::POS_OK }
    all = all.inject([]){ |result,h| result << h unless result.include?(h); result }
    KEY_POS_COUNTS[id] = all.size
  end


  def keys_count
    return KEY_COUNTS[id] if KEY_COUNTS[id]
    KEY_COUNTS[id] = keys.count
    # @keys_count ||= repository(:default).adapter.select("SELECT DISTINCT(created_on) COUNT(*) FROM positions LIMIT 100")
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