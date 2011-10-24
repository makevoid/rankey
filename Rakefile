#!/usr/bin/env rake

path = File.expand_path "../", __FILE__
# 
# require "bundler/setup"
# Bundler.require :dm
# 
# require 'resque'
# 


require File.expand_path('../config/application', __FILE__)
# if ENV['TRAVIS']
  Rankey::Application.load_tasks
# end

require 'rspec/core/rake_task'

desc "Run all specs"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = ["-b", "-c", "-fd"]
  t.pattern = 'spec/**/*_spec.rb'
end


task :default => :spec


# Dir.glob("#{path}/app/models/*.rb").map do |model|
#   require model
# end
# Dir.glob("#{path}/app/workers/*.rb").map do |model|
#   require model
# end

# Dir.glob("#{path}/lib/tasks/*.rake").map do |task|
#   load task
# end

