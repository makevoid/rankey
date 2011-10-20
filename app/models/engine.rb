class Engine
  
  ENGINES = [:google, :yahoo, :bing]
  
  def self.all
    ENGINES.map{ |e| eval(e.to_s.capitalize) }
  end
  
  
  def self.engine_name(idx=nil)
    if idx 
      ENGINES[idx-1]
    else
      name.downcase
    end
  end
  
  
end