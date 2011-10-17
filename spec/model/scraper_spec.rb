path = File.expand_path "../../../", __FILE__
# require "#{path}/spec_models_helper"
require "#{path}/app/models/scraper"

# site = Site.create name: "makevoid.com"
# site.keys.create name: "makevoid"

describe "Scraper" do
  
  before do
    @s = Scraper.new fixture: true
  end
  
  describe "Google" do
    it "should scrape a key" do
      res = @s.scrape Google, "bmw.com", "bmw"
      res.should == 1
    end
    
    it "should not return position for ad result" do
      res = @s.scrape Google, "bmw.co.uk", "bmw"
      res.should == 7
    end
  end
  
  describe "Yahoo" do
    it "should scrape a key" do
      res =@s.scrape Yahoo, "bmwgroup.com", "bmw"
      res.should == 5
    end
  end
  
  describe "Bing" do
    it "should scrape a key" do
      res = @s.scrape Bing, "bmw.dk", "bmw"
      res.should == 2
    end

    it "should return a nil pos for a bad scrape " do
      res = @s.scrape Bing, "lololol", "bmw"
      res.should == nil
    end
  end
  
end