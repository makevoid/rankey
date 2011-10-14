path = File.expand_path "../../../", __FILE__

require "bundler/setup"
Bundler.require :dm, :dm_test


DataMapper.setup(:default, "mysql://localhost/rankey_test")

Dir.glob("#{path}/app/models/*.rb").map do |model|
  require model
end

DataMapper.auto_migrate!