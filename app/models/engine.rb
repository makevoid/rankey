class Engine
  
  ENGINES = [:google, :yahoo, :msn]
  
  def self.name(idx)
    ENGINES[idx]
  end
  
  def self.id(name)
    ENGINES.index name.to_sym
  end
  
end