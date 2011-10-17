path = File.expand_path "../../../", __FILE__
SCRAPER_PATH = path

require 'nokogiri'
require "#{path}/lib/nokogiri_exts"
require_relative "google"
require_relative "yahoo"
require_relative "bing"

class Scraper
  
  def initialize(options={fixture: false})
    @options = options
    require 'mechanize'
    @agent = Mechanize.new
    @agent.user_agent = 'Mac Safari'
  end
  
  def scrape(engine, domain, key)
    page = get(engine, key)
    # raise page.inner_html.inspect
    # raise engine.page_results(page).inspect
    # engine.page_results(page).inspect
  
    engine.page_results(page).each_with_index do |res, idx|
      dom = res.inner_link_text
      # puts dom
      # puts domain
      return idx+1 if dom.include? domain
    end
    nil
  end
  
  
  private
  
  def get(engine, key)
    unless @options[:fixture]
      engine.add_cookies @agent if engine == Bing
      @agent.get engine.base_url(key)
      # @agent.get Google.base_url(key)
    else
      get_fixture engine, key
    end
  end
  
  def get_fixture(engine, key)
    key = key.downcase.gsub(/\s+/, '_')
    Nokogiri::HTML File.read("#{SCRAPER_PATH}/spec/fixtures/#{engine.engine_name}_#{key}.html")
  end

end
# 



# s = Scraper.new
# p s.scrape("tokyustayresidence.com", "ebisu")
# p s.scrape_base(Bing, "tokyustayresidence.com", "ebisu")
# p s.scrape(Bing, "bmw.dk", "bmw")
