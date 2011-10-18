path = File.expand_path "../../../", __FILE__

DataMapper.setup(:default, 'mysql://localhost/rankey_development')
require 'resque/tasks'

# rake resque:work QUEUE='*'
task "resque:setup" => :environment


namespace :resque do

  desc "executes workers"
  task :scrape do 
    require "#{path}/app/models/key"
    require "#{path}/app/workers/scraper_worker"
    Key.all(limit: 3).each do |key|
      Resque.enqueue(ScraperWorker, key.id)
    end
  end
  
end