class EngineError < RuntimeError
  def message
    "Engine error, the engine doesn't accept more requests"
  end
end

class Crawler
  
  # SKIP_YAHOO = true
  SKIP_YAHOO = false
  
  def initialize(opts={})
    @scraper = Scraper.new opts
  end
  
  # new crawl (smart)
  
  def crawl(engine)
    @engine = engine
    # new crawl
    keys = Key.all#[600..610]
    
    7.downto(0) do |gap|
      keys.each do |key| 
        # p key
        pos = Position.count(key: key, :created_on.lte => Date.today, :created_on.gte => Date.today-gap, id_engine: engine.id); 
        # p pos
        if pos == 0 
          site = key.site
          scrape_base engine, site.name, key, gap
        end
      end
    end
  end
  
  # everyday crawl (less keywords)
  # 
  # def crawl(engine)
  #   @engine = engine
  #   Site.all.each do |site|
  #     scrape_site(site)
  #   end
  #   
  #   true # TODO: consider returning a crawl status
  # end
  # 
  # def scrape_site(site, options={debug: false})
  #   limit = options[:debug] ? 1 : -1
  #   site.keys[0..limit].each do |key|
  #     scrape_key site.name, key
  #   end
  # end
  
  
  # more keywords crawl
  
  # def crawl
  #   keys= Key.all
  #   positions = keys.map do |key| 
  #     # Engine.all.map do |engine|
  #       engine_id = Google.id
  #       Position.first(id_engine: engine_id, :key => key, :order => :created_on.desc)
  #     # end
  #   end
  #   
  #   positions.each do |pos|
  #     key = pos.key
  #     site = key.site
  #     scrape_key site.name, key
  #   end
  #   
  #   true # TODO: consider returning a crawl status
  # end

  

  # def scrape_key(domain, key)
  #   # Engine.all.each do |engine|
  #   engine = @engine
  #   # next if SKIP_YAHOO && engine == Yahoo 
  #   exists = Position.count(created_on: Date.today, key: key, id_engine: engine.id) >= 1
  #   scrape_base engine, domain, key unless exists
  #   # end 
  # end
  
  def scrape_base(engine, domain, key, gap=nil)
    result = begin 
      @scraper.scrape(engine, domain, key.name)
    rescue EngineError 
      @scraper.logger do |log|
        log.puts "Error: Engine Error on '#{engine}'"
      end
      :fail
    end
    
    @scraper.logger do |log|
      log.puts "#{Time.now.strftime("%m-%d %H:%M")} - gap: #{gap} - #{result}\t #{key.name} - #{engine} [#{domain}]"
    end
    # puts "#{Time.now.strftime("%m-%d %H:%M")} - #{result}\t #{key.name} - #{engine} [#{domain}]"
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
