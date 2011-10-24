require_relative "engine"

# path = File.expand_path "../", __FILE__
# require "#{path}/engine"

class Google < Engine
  
  def self.id
    1
  end
  
  def self.base_url(query)
    "http://google.com/search?num=100&hl=#{COUNTRY}&q=#{query}"
  end
  
  def self.page_results(page)
    results = page.search("#center_col")
    # "#taw" -> sponsored results
    # "#res" -> organic results
    results.search("#res").search("cite")
  end
end