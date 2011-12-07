path = File.expand_path "../../../", __FILE__
APP_PATH = path

require 'nokogiri'
require "#{path}/lib/nokogiri_exts"
require_relative "google"
require_relative "yahoo"
require_relative "bing"

class Scraper
  
  SLEEP = 2
  # SLEEP = 20
  
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
      if res.nil?
        puts "got nil result"
        puts page.inspect
      end
      dom = res.inner_link_text
      # puts dom
      # puts domain
      return idx+1 if dom.include? domain
    end
    nil
  end
  
  def logger(&block)
    File.open("#{APP_PATH}/log/scraper.log", "a"){ |f| block.call f }
  end  
  
  private
  
  def get(engine, key)
    unless @options[:fixture]
      engine.add_cookies @agent if engine == Bing
      
      url = engine.base_url(key)
      
      times = 0
      begin
        times += 1
        page = @agent.get url
        sleep SLEEP if SLEEP
        page
        
      rescue Mechanize::ResponseCodeError => e
        if times < 4
          @agent = Mechanize.new
          @agent.user_agent = 'Mac Firefox'
          
          sleep times*2
          puts "got: #{e.message} - retrying: #{times}* time"
          puts "#{e.page.body}"
          
          if times < 3 #spawn new agent
            @agent = Mechanize.new
            @agent.user_agent = 'Mac Safari'
          end
          
          retry 
        end
        
        logger do |log| 
          get_error = lambda{ |urlz, er| "Error: Scraper getting url: #{urlz} raising #{er.class}: #{er.message} - Scraper.get" }
          err = get_error.call(url, e)
          log.puts err
          puts err
          
          raise EngineError if e.response_code.to_i == 999
        end  
        nil
      end
      
      
      # @agent.get Google.base_url(key)
    else
      get_fixture engine, key
    end
  end
  
  
  def get_fixture(engine, key)
    key = key.downcase.gsub(/\s+/, '_')
    Nokogiri::HTML File.read("#{APP_PATH}/spec/fixtures/#{engine.engine_name}_#{key}.html")
  end

end
# 



# s = Scraper.new
# p s.scrape("tokyustayresidence.com", "ebisu")
# p s.scrape_base(Bing, "tokyustayresidence.com", "ebisu")
# p s.scrape(Bing, "bmw.dk", "bmw")
