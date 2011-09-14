class User
  include DataMapper::Resource
  
  # belongs_to :role
  
  property :id, Serial
  property :name, String, length: 150
  property :email, String, length: 150
  
  # oauth
  
  
end