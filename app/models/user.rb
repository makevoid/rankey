class User
  include DataMapper::Resource
  
  # belongs_to :role
  
  property :id, Serial
  property :name, String, length: 150
  property :email, String, length: 150
  property :crypted_password, String
  property :salt, String
  property :created_at, DateTime
  property :updated_at, DateTime
  
  # authenticates_with_sorcery! # ar only
  
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