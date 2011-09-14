class Scraper
  
  require 'mechanize'
  
  def initialize(args)
    @agent = Mechanize.new
  end
  
  def scrape(key)
    @agent.get Google.base_url
  end
  
  def scrape_with(key, engine)
    
  end
  
end