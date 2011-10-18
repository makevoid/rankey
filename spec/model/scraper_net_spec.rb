path = File.expand_path "../", __FILE__
require "#{path}/spec_models_helper"

describe "Scraper" do
  
  before do
    @s = Scraper.new # fixture: false
  end
  
  describe "Google" do
    it "should scrape a key" do
      res = @s.scrape Google, "bmw.com", "bmw"
      res.should be_a(Integer)
    end
    
    it "should not return position for ad result" do
      res = @s.scrape Google, "bmw.co.uk", "bmw"
      res.should be_a(Integer)
    end
  end

end