path = File.expand_path "../../../", __FILE__

require "bundler/setup"
Bundler.require :dm, :dm_test

ENV["RAILS_ENV"] = "travis" if ENV["TRAVIS"]
env = ENV["RAILS_ENV"] || "test"
ENV["RAILS_ENV"] = env

DataMapper.setup(:default, "mysql://localhost/rankey_#{env}")

Dir.glob("#{path}/app/models/*.rb").map do |model|
  require model
end

DataMapper::Logger.new($stdout, :debug)

DataMapper.auto_migrate!