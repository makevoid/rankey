require 'spec_helper'

load "#{Rails.root}/app/models/user.rb"

describe "Sessions", :type => :request do
  
  it "should login with right username" do
    user = "makevoid@gmail.com"
    pass = "secret"
    group = Group.create name: "test"
    gr = group.users.create(username: user, password: pass)
    u = User.first
    # p gr.errors.inspect
    post "/sessions.json", { username: user, password: pass, remember_me: true }
    resp = JSON.parse response.body
    resp.symbolize_keys!
    puts resp.inspect
    resp[:success].should == { "message" => "Logged in!" }
  end
  
end

