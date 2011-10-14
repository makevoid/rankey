#!/usr/bin/env rake

path = File.expand_path "../", __FILE__
# 
# require "bundler/setup"
# Bundler.require :dm
# 
# require 'resque'
# 


require File.expand_path('../config/application', __FILE__)
Rankey::Application.load_tasks



DataMapper.setup(:default, 'mysql://localhost/rankey_development')
# Dir.glob("#{path}/app/models/*.rb").map do |model|
#   require model
# end
# Dir.glob("#{path}/app/workers/*.rb").map do |model|
#   require model
# end

# Dir.glob("#{path}/lib/tasks/*.rake").map do |task|
#   load task
# end

