require 'spec_helper'

describe "Rankey", :type => :request  do
  
  it "should render the app page (/)" do
    visit "/"
    response.should =~ /Rankey/
  end
  
end

