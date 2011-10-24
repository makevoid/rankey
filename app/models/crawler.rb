class EngineError < RuntimeError
  def message
    "Engine error, the engine doesn't accept more requests"
  end
end

class Crawler
  
  def initialize(opts={})
    @scraper = Scraper.new opts
  end
  
  def self.crawl!(opts={})
    new(opts).crawl
  end
    
  def crawl
    Site.all.each do |site|
      scrape_site(site)
    end
    
    true # TODO: consider returning a crawl status
  end
  
  def scrape_site(site, options={debug: false})
    limit = options[:debug] ? 1 : -1
    site.keys[0..limit].each do |key|
      scrape_key site.name, key
    end
  end
  
  def scrape_key(domain, key)
    
    Engine.all.each do |engine|
      exists = Position.count(created_on: Date.today, key: key, engine_id: engine.id) >= 1
      # exists = false
      scrape_base engine, domain, key unless exists
    end 
  end
  
  def scrape_base(engine, domain, key)
    result = begin 
      @scraper.scrape(engine, domain, key.name)
    rescue EngineError 
      @scraper.logger do |log|
        log.puts "Error: Engine Error on '#{engine}'"
      end
      :fail
    end
    
    puts "#{result}\t #{key.name} - #{engine} - #{domain}"
    save_result result, key, engine unless result == :fail
  end
  
  def save_result(result, key, engine)
    key.positions.create pos: result, engine: engine
  end
  
end

## debug
# 

# require 'bundler/setup'
# Bundler.require :dm
# 
# path = File.expand_path "../../../", __FILE__
# 
# Dir.glob("#{path}/app/models/*.rb").map do |model|
#   require model
# end
# 
# DataMapper.finalize
# DataMapper.setup(:default, 'mysql://localhost/rankey_development')
# 
# DataMapper.auto_migrate!
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
# Position.today.each{ |p| p.destroy }
# 
# c = Crawler.new# fixture: true
# c.crawl
