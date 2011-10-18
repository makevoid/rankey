require 'spec_helper'

describe "Rankey", :type => :request  do
  
  it "should render the app page (/)" do
    get "/"
    response.body.should =~ /Rankey/
  end
  
end

