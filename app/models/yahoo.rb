require_relative "engine"

class Yahoo < Engine
  def self.id
    2
  end
  
  def self.base_url(query)
    ###
    "http://it.search.yahoo.com/search?p=#{query}&n=100"
  end
  
  def self.page_results(page)
    results = page.search("#cols")
    # "#spns em" -> sponsored results
    results.search("span.url")
  end
end