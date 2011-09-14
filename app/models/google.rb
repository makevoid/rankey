class Google < Engine
  def self.id
    1
  end
  
  def self.base_url(query)
    "http://google.com/q?=#{query}"
  end
end