require 'bundler/setup'
Bundler.require :dm

path = File.expand_path "../../", __FILE__

Dir.glob("#{path}/app/models/*.rb").map do |model|
  require model
end

DataMapper.finalize
DataMapper.setup(:default, 'mysql://localhost/rankey_development')

# Position.today.each{ |p| p.destroy }

c = Crawler.new# fixture: true
c.crawl
