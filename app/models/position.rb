class Position
  include DataMapper::Resource
  
  property :key_id, Integer, min: 1, index: true
  belongs_to :key
  
  property :id_engine, Integer
  # property :engine_id, Integer, min: 1, index: true
  # belongs_to :engine
  
  property :id, Serial
  property :pos, Integer, index: true
  # property :engine_id, Integer
  property :created_on, Date, index: true 
  
  before :create do
    self.created_on = Date.today unless self.created_on
  end
  
  def self.google
    all(id_engine: Google.id)
  end
  
  def self.history
    all(created_on: history_days)
  end
  
  def self.history_days(much=:lots)
    num = much == :lots ? 12 : 3
    num.downto(0).map do |i|
      Date.today - i*7 # weeks
    end
  end
  
  
  def self.today
    all(created_on: Date.today)
  end
  
  def self.optimistic
    # TODO: move in the model
    # all(:pos.gte => Rankey::POS_OK )
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
    self.id_engine = klass.send "id"
  end
  
  def engine
    Engine.engine_name(id_engine)
  end
  
end