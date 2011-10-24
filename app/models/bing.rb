require_relative "engine"

class Bing < Engine
  
  RESULTS_NUM = 100 # max is 200 for bing
  
  # TODO: remove?
  # path = File.expand_path "../../../", __FILE__
  # require "#{path}/lib/nokogiri_exts"
  
  def self.id
    3
  end
  
  def self.base_url(query)
    "http://#{COUNTRY}.bing.com/search?q=#{query}&n=#{RESULTS_NUM}"
  end
  
  def self.page_results(page)
    # results = page.search(".sb_results")
    # puts results.inspect
    # "#spns em" -> sponsored results
    page.search("cite")
  end
  
  # only for bing (guess why)
  def self.add_cookies(agent)
    uri, path, domain = URI.parse('http://bing.com'), "/", ".bing.com"

    cookie = Mechanize::Cookie.new "DOB", "20111011"
    cookie.domain = domain; cookie.path = path
    agent.cookie_jar.add uri, cookie

    cookie = Mechanize::Cookie.new "SRCHHPGUSR", "NEWWND=0&NRSLT=#{RESULTS_NUM}" 
    cookie.domain = domain; cookie.path = path
    agent.cookie_jar.add uri, cookie
  end
  
end





# 
# m = Mechanize.new
# m.user_agent = 'Mac Safari'
# 
# 
# 
# add_cookies(m)
# 
# page = m.get "http://www.bing.com/search?q=makevoid&n=50"
# 
# p page.body



# Bing.page_results(page).each_with_index do |txt, idx|
#   p idx+1, txt.inner_link_text
# end




# Host: www.bing.com
# User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:6.0.2) Gecko/20100101 Firefox/6.0.2
# Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
# Accept-Language: en-us,en;q=0.5
# Accept-Encoding: gzip, deflate
# Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.7
# Connection: keep-alive
# Cookie: DOB=20111011; SRCHHPGUSR=NEWWND=0&NRSLT=1000
# Cache-Control: max-age=0
