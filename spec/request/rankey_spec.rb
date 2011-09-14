require 'spec_helper'

describe "Rankey" do
  
  it "should render the app page (/)" do
    visit "/"
    response.should =~ /Rankey/
  end
  
end

