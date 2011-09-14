class Position
  include DataMapper::Resource
  
  belongs_to :key
  # belongs_to :engine
  
  property :id, Serial
  property :pos, Integer 
  property :engine_id, Integer
  property :date, Date 
  
  # FIXME: mbe?
  before :save do
    self.date = Date.today
  end
  
  def engine=(klass)
    self.engine_id = klass.send "id"
  end
end