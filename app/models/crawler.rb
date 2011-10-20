class Crawler
  
  def initialize(opts={})
    @scraper = Scraper.new opts
  end
  
  def self.crawl!(opts={})
    new(opts).crawl
  end
    
  def crawl
    Site.all.each do |site|
      scrape(site)
    end
    
    true # TODO: consider returning a crawl status
  end
  
  def scrape(site, options={debug: false})
    domain = site.name
    limit = options[:debug] ? 1 : -1
    domain.keys[0..limit].each do |key|
      scrape_key domain, key
    end
  end
  
  def scrape_key(domain, key)
    Engine.all.each do |engine|
      scrape_base engine, domain, key
    end
  end
  
  def scrape_base(engine, domain, key)
    @scraper.scrape(engine, domain.name, key.name)
  end
  
end

## debug
# 
# require 'dm-core'
# require 'dm-aggregates'
# path = File.expand_path "../../../", __FILE__
# 
# Dir.glob("#{path}/app/models/*.rb").map do |model|
#   require model
# end
# 
# DataMapper.setup(:default, 'mysql://localhost/rankey_development')
# 
# sites = [
#   { 
#     name: "makevoid.com", 
#     keys: ["makevoid", ["ruby on rails", "ruby", "rails"], ["web apps", "apps"], "firenze"]      
#   }
# ]
# 
# sites.each do |site|
#   site_obj = Site.create name: site[:name]
#   keys = Keys.new site[:keys]
#   
#   keys.all.each do |key_name|
#     site_obj.keys.create name: key_name
#   end
# end
# 
# 
# c = Crawler.new fixture: true
# c.crawl
