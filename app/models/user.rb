require 'digest/sha2'

class User
  include DataMapper::Resource
  
  # belongs_to :role
  
  property :id, Serial
  property :email, String, length: 150
  property :name, String, length: 150
  property :crypted_password, String
  property :salt, String
  
  property :session, String
  property :created_at, DateTime
  property :updated_at, DateTime
  
  property :group_id, Integer, min: 1, index: true
  belongs_to :group
  
  property :admin, Boolean, default: false
  property :optimist, Boolean, default: false # an optimist is a user that sees only 
  
  def username=(user)
    self.email = user
  end
  
  def public_attributes
    filtereds = %w(crypted_password salt)
    publics = {}
    attributes.each do |name, val|
      publics[name] = val unless filtereds.include? name.to_s 
    end
    publics[:group] = { name: group.name }
    publics
  end
  
  def sites
    group.sites
  end
  
  attr_accessor :password
  
  before :save do
    if self.password
      self.salt = User.generate_salt
      self.crypted_password = User.crypt(self.password, self.salt)
    end
    self.generate_session
  end
  
  def generate_session
    str = "_#{Time.now.to_i}>.<#{User.secret_key.reverse}lalalal"
    self.session = Digest::SHA2.hexdigest(str)[0..15]
  end
  
  def generate_session!
    generate_session
    save
  end
  
  def self.secret_key
    "antanisupercazzolasblinda"
  end
  
  def good_password?(pass)
    crypted_password == crypt(pass)
  end
  
  def crypt(pass)
    User.crypt(pass, salt)
  end
  
  def self.crypt(pass, salt)
    Digest::SHA2.hexdigest("#{pass}o.O#{salt}:v#{self.secret_key}")[0..30]
  end
  
  def self.generate_salt
    str = "_#{Time.now.to_i}_#{self.secret_key}"
    Digest::SHA2.hexdigest(str)[0..20]
  end
  
  
  
  # authenticates_with_sorcery! # ar only
  
  def self.authenticate(username, password, remember_me)
    user = User.first email: username
    user if !user.nil? && user.good_password?(password)
  end
  
  
  # TODO absolutely
  
  # add_column :users, :reset_password_token, :string, :default => nil
  # add_column :users, :reset_password_token_expires_at, :datetime, :default => nil
  # add_column :users, :reset_password_email_sent_at, :datetime, :default => nil
  
  # add_column :users, :activation_state, :string, :default => nil
  # add_column :users, :activation_token, :string, :default => nil
  # add_column :users, :activation_token_expires_at, :datetime, :default => nil
  # add_index :users, :activation_token
  
  # add_column :users, :remember_me_token, :string, :default => nil
  # add_column :users, :remember_me_token_expires_at, :datetime, :default => nil
  # add_index :users, :remember_me_token
  
  # oauth
end