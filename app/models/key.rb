class Key
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String, length: 100
  
  belongs_to :site
  has n, :positions
  
  def scrape
    
    s = Scraper.new
    pos = s.scrape(site.name, name)
    
    puts "found key #{name} on pos #{pos} for site #{site.name}"
    
    # engines.each ...
    # puts self.positions.inspect
    self.positions.create pos: pos, engine: Google
    # puts "diahanz"
    # self.positions.create pos: 10, engine_id: 1
    # pos = Position.new(key_id: id)
    # pos.save
    
  end
end