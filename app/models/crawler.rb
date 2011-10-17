class Crawler
  
  def initialize
    @scraper = Scraper.new
  end
  
  def self.crawl!
    new.crawl
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