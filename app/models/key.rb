class Key
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String, length: 100
  
  belongs_to :site
  has n, :positions
end