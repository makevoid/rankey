PATH = File.expand_path "../../", __FILE__

def models_path(model)
  "#{PATH}/app/models/#{model}"
end


require 'bundler'
require 'bundler/setup'
Bundler.require(:dm)

DataMapper.setup(:default, "mysql://localhost/rankey_development")
require models_path("engine")

models = Dir.glob models_path("*.rb")
models.each do |model|
  require model
end

DataMapper.auto_migrate!

sites = [
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
    keys: [ ["torrent", "thorrents"], ["tpb", "piratebay"], "italia" ]
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


user = User.new
user.username = "makevoid@gmail.com"
user.password = "secret"
user.save

sites.each do |site|
  site_obj = Site.create name: site[:name]
  
  # puts site[:name]#, " -> ", site[:keys].inspect
  keys = Keys.new site[:keys]
  # puts keys.all.inspect, "\n"
  
  keys.all.each do |key_name|
    key = site_obj.keys.create name: key_name
    
    Position.history_days.each do |day|
      key.positions.create pos: rand(99)+1, engine: Google, created_on: day
      key.positions.create pos: rand(99)+1, engine: Yahoo, created_on: day
      key.positions.create pos: rand(99)+1, engine: Bing, created_on: day
    end
    
  end
end


