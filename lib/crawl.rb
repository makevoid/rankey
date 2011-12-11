env = ARGV[0] || "development"

require 'bundler/setup'
Bundler.require :dm

path = File.expand_path "../../", __FILE__

Dir.glob("#{path}/app/models/*.rb").map do |model|
  require model
end

engine = eval(ARGV[1].capitalize)
raise "pass a valid engine, please" unless Engine.all.include? engine

DataMapper.finalize
if env == "production"
  conf = YAML::load File.read("#{path}/config/database.yml")
  pass = conf["production"]["password"]
  pass = "root:#{pass}@"
end

DataMapper.setup(:default, "mysql://#{pass}localhost/rankey_#{env}")

# Position.today.each{ |p| p.destroy }

c = Crawler.new# fixture: true
c.crawl engine
