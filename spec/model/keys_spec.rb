# require 'spec_helper'

path = File.expand_path "../../../", __FILE__
require "#{path}/app/models/keys"

describe Keys do
  
  # dumb version
  
  # it "should return correct keys" do
  #   keys = Keys.new ["a", "b", "c"]
  #   keys.all.should == ["a", "b", "c", "a b", "a c", "b c", "a b c"]
  # end
  
  it "should return correct keys" do
    keys = Keys.new ["a", ["b", "c"]]
    keys.all.should == ["a", "b", "c", "a b", "a c"]
  end
  
  it "should return correct keys right?!? [A]" do
    keys = Keys.new [["b", "c"], "d"]
    keys.all.should == ["b", "c", "d", "b d", "c d"]
  end
  
  it "should return correct keys right?!? [B]" do
    keys = Keys.new ["a", ["b", "c"], "d"]
    keys.all.should == ["a", "b", "c", "d", "a b", "a c", "b d", "c d", "a d", "a b d", "a c d"]
  end
  
  it "should return correct keys right?!? [C]" do
    keys = Keys.new ["a", ["b", "c"], ["d", "e"]]
    keys.all.should == ["a", "b", "c", "d", "e", "a c", "a b", "a d", "c e", "b d", "b e", "c d", "a e", "a b d", "a b e", "a c d", "a c e"]
  end
  
  
end