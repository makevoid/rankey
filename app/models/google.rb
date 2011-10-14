class Google < Engine
  def self.id
    1
  end
  
  def self.base_url(query)
    "http://google.com/search?q=#{query}&num=100"
  end
  
  def self.page_results(page)
    results = page.search("#center_col")
    # "#taw" -> sponsored results
    # "#res" -> organic results
    results.search("#res").search("cite")
  end
end