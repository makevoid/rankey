path = File.expand_path "../../../", __FILE__

require "bundler/setup"
Bundler.require :dm

# Dir.glob("#{path}/app/models/*").map do |model|
#   require model
# end
DataMapper.setup(:default, "mysql://localhost/rankey_test")
DataMapper.auto_migrate!

require "#{path}/app/models/user"