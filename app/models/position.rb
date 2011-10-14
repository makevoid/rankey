class Position
  include DataMapper::Resource
  
  belongs_to :key
  # property :key_id, Integer, index: true
  # belongs_to :engine
  
  property :id, Serial
  property :pos, Integer, index: true
  property :engine_id, Integer
  property :created_on, Date, index: true 
  
  before :create do
    self.created_on = Date.today unless self.created_on
  end
  
  def self.google
    all(engine_id: Google.id)
  end
  
  def self.history
    all(created_on: history_days)
  end
  
  def self.history_days
    12.downto(0).map do |i|
      Date.today - i*7 # weeks
    end
  end
  
  def self.today
    all(created_on: Date.today)
  end
  
  def pos_ok
    pos <= Rankey::POS_OK
  end
  
  def date
    created_on
  end
  
  def date=(obj)
    created_on = obj
  end

  def engine=(klass)
    self.engine_id = klass.send "id"
  end
  
  def engine
    Engine.name(engine_id)
  end
  
end