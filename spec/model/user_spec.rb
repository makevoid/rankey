# require "spec_helper"
path = File.expand_path "../../", __FILE__
require "#{path}/spec_helper"

describe User do
  it "should find an user" do
    g = Group.create(name: "test")
    u = g.users.new
    u.username = "makevoid@gmail.com" 
    u.password = "secret"
    u.save
    # User.first.should_not be_nil
    User.first.should be_a(User)
  end
  
  it "should create an user" do
    
  end
end