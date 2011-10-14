PATH = File.expand_path "../../../", __FILE__
FIXTURE = {}

require "#{PATH}/lib/nokogiri_exts"

class Scraper
  
  @@testing = false
  
  def initialize
    unless @@testing
      require 'mechanize'
      @agent = Mechanize.new
      @agent.user_agent = 'Mac Safari'
    end
  end
  
  def self.testing=(t)
    @@testing = t
    if t
      require 'nokogiri'
      FIXTURE[:google] = Nokogiri::HTML File.read("#{PATH}/spec/fixtures/google_ebisu.html")
      FIXTURE[:yahoo] = Nokogiri::HTML File.read("#{PATH}/spec/fixtures/yahoo_ebisu.html")
      FIXTURE[:bing] = Nokogiri::HTML File.read("#{PATH}/spec/fixtures/bing_ebisu.html")
    end
  end
  
  def get(engine, key)
    unless @@testing
      @agent.get Google.base_url(key)
    else
      FIXTURE[engine]
    end
  end
  
  def scrape(domain, key)
    page = get(:google, key)
    Google.page_results(page).each_with_index do |res, idx|
      dom = res.inner_link_text
      # puts dom
      return idx+1 if dom.include? domain
    end
    nil
  end
  
  def scrape_with(key, engine)
    
  end
  
end
# 
# require_relative "engine"
# require_relative "google"
# Scraper.testing = true
# s = Scraper.new
# p s.scrape("tokyustayresidence.com", "ebisu")