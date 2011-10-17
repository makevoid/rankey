require_relative "../models/scraper"



class ScraperWorker
  
  @queue = :scrapers
  
  def self.perform(key_id)
    puts "testing"
    key = Key.get(key_id)
    key.scrape

  end
  

  
end