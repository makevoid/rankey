class Group
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String, length: 100
  
  has n, :users, constraint: :destroy
  has n, :sites, constraint: :destroy
end