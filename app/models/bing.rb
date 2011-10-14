path = File.expand_path "../../../", __FILE__
require_relative "engine"


class Bing < Engine
  def self.id
    3
  end
  
  def self.base_url(query)
    "http://www.bing.com/search?q=#{query}&n=100"
  end
  
  def self.page_results(page)
    results = page.search("#results")
    # "#spns em" -> sponsored results
    results.search("cite")
  end
  
end

require 'mechanize'
require "#{path}/lib/nokogiri_exts"

m = Mechanize.new
m.user_agent = 'Mac Safari'


def add_cookies(agent)
  uri, path, domain = URI.parse('http://bing.com'), "/", ".bing.com"
  
  cookie = Mechanize::Cookie.new "DOB", "20111011"
  cookie.domain = domain; cookie.path = path
  agent.cookie_jar.add uri, cookie

  cookie = Mechanize::Cookie.new "SRCHHPGUSR", "NEWWND=0&NRSLT=100" # max is 200
  cookie.domain = domain; cookie.path = path
  agent.cookie_jar.add uri, cookie
end

add_cookies(m)

page = m.get "http://www.bing.com/search?q=makevoid&n=50"

p page.body

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
