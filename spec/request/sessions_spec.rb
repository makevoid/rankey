require 'spec_helper'

load "#{Rails.root}/app/models/user.rb"

describe "Sessions", :type => :request do
  
  it "should login with right username" do
    user = "makevoid@gmail.com"
    pass = "secret"
    User.create(username: user, password: pass)
    u = User.first
    puts "good pass?: ", u.good_password?(pass)
    puts "good pass?: ", u.good_password?(pass)
    post "/sessions.json", { username: user, password: pass, remember_me: true }
    resp = JSON.parse response.body
    resp.symbolize_keys!
    puts resp.inspect
    resp[:success].should == true
  end
  
end

