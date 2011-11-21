path = File.expand_path "../", __FILE__
require "#{path}/spec_models_helper"

describe Site do
  
  it "should update keys" do
    site = Site.create(name: "test")
    site.keys.create(name: "a")
    site.keys.create(name: "b")
    site.keys.create(name: "a b")
    site.keys.create(name: "z")
    
    site.update_keys ["a", "b", ["c", "d"]]
    
    keys = [
      "c"    ,
      "d"    ,
      "a b"  ,
      "a d"  ,
      "b c"  ,
      "b d"  ,
      "a c"  ,
      "a b c",
      "a b d",
    ]
    
    keys.each do |key|
      # puts key
      Key.first(name: key).should_not be_nil
    end
    
    Key.first(name: "z").should be_nil
  end
  
end