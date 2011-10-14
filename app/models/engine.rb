class Engine
  
  ENGINES = [:google, :yahoo, :msn]
  
  def self.name(idx)
    ENGINES[idx-1]
  end
  
  def self.id(name)
    ENGINES.index name.to_sym
  end
  
  def self.eng(name)
    name.constantize
  end
  
end