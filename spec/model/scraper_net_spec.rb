path = File.expand_path "../", __FILE__
require "#{path}/spec_models_helper"

describe "Scraper" do
  it "should scrape a key" do
    site = Site.create name: "makevoid.com"
    key = site.keys.create name: "makevoid"
    pos = key.scrape
    pos.pos.should != nil
  end
end