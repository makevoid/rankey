class Engine
  
  ENGINES = [:google, :yahoo, :bing]
  
  def self.all
    ENGINES.map{ |e| e.name.constantize }
  end
  
  
  def self.engine_name(idx=nil)
    if idx 
      ENGINES[idx-1]
    else
      name.downcase
    end
  end
  
  
end