path = File.expand_path "../", __FILE__
require "#{path}/spec_models_helper"


describe Crawler do
  it "should crawl eeeverything!" do
    Crawler.crawl!.should == true
  end
  
  
end

