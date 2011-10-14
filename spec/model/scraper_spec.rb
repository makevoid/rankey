path = File.expand_path "../", __FILE__
require "#{path}/spec_models_helper"

Scraper.testing = true

site = Site.create name: "makevoid.com"
site.keys.create name: "makevoid"

describe "Scraper" do
  it "should scrape a key" do
    site = Site.create name: "tokyustayresidence.com"
    key = site.keys.create name: "ebisu"
    pos = key.scrape
    pos.pos.should == 88
  end
  
  it "should return a nil pos for a bad scrape " do
    site = Site.create name: "whatever.com"
    key = site.keys.create name: "whatever"
    pos = key.scrape
    pos.pos.should == nil
  end
end