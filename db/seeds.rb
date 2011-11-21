PATH = File.expand_path "../../", __FILE__

def models_path(model)
  "#{PATH}/app/models/#{model}"
end


require 'bundler'
require 'bundler/setup'
Bundler.require(:dm)

env = ARGV[0] || "development"

DataMapper.setup(:default, "mysql://localhost/rankey_#{env}")
require models_path("engine")

models = Dir.glob models_path("*.rb")
models.each do |model|
  require model
end

DataMapper.auto_migrate!

exit if env == "test"

sites = [
  { 
    name: "gystyle.com", 
    keys: [["shopping", "outlet"], "online", ["make up", "prodotti", "abbigliamento", "vestiti", "abiti", "vino",  "giacche", "moda", "moda accessori", "borse", "sedie", "cashemere", "gastronomia", "pasta", "ballerine", "cappotti", "cinture"], ["italy", "made in italy"]]
  },
  { 
    name: "makevoid.com", 
    keys: ["makevoid", ["ruby on rails", "ruby", "rails"], ["web apps", "apps"], "firenze"]      
  },
  {
    name: "pixbits.com",
    keys: ["pixbits", "junk jack", ["ios", "iphone", "mobile"], ["game", "app"]]
  },
  { 
    name: "stylequiz.net",
    keys: ["stylequiz", "facebook", ["fashion", "style"], "game"] 
  },
  { 
    name: "skicams.it",
    keys: [ ["skicams", "ski", "webcams"], "iphone", "app" ]
  },
  { 
    name: "thorrents.com",
    keys: [ ["torrents", "thorrents"], ["tpb", "piratebay"], "italia" ]
  },
  { 
    name: "pietroporcinai.com",
    alt: ["pietroporcinai.it"],
    keys: [ ["pietro porcinai", "porcinai"], ["architetto", "architettura"], "giardini", ["paesaggio", "paesaggista"] ]
  },
  { 
    name: "mangapad.org",
    keys: [ "mangapad", "manga", ["read", "view"], ["ipad", "ios", "webapp"] ]
  },
  { 
    name: "jscrape.it",
    keys: [ "jscrape", ["scrape", "scraper"], "javascript" ]
  },
]


user = User.new(name: "Francesco Canessa")
user.username = "makevoid@gmail.com"
user.password = "secret"
user.save

sites.each do |site|
  keys = Keys.new site[:keys]
  site_obj = Site.create name: site[:name], keys_src: site[:keys]
  
  keys.all.each do |key_name|
    key = site_obj.keys.create name: key_name
    
    Position.history_days(:fews).each do |day|
      Engine.all.each do |engine|
        key.positions.create pos: rand(99)+1, engine: engine, created_on: day
      end
    end
  end
end


