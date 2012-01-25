if ARGV[0].nil? || ARGV[1].nil?
  puts "
usage:
  
  ruby lib/crawl.rb ENV ENGINE
  

example:

  ruby lib/crawl.rb development google

  "
  exit
end

env = ARGV[0]
ENV["RAILS_ENV"] = env

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
