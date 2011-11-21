class Key
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String, length: 100
  
  property :site_id, Integer, min: 1, index: true
  belongs_to :site
  
  
  has n, :positions, constraint: :destroy # hmm.. sure?
end