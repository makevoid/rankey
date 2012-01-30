source :rubygems

DM_VERSION    = '~> 1.3.0.beta'
DM_VERSION2    = '~> 1.1.1'

DATAMAPPER = "git://github.com/datamapper"

group :development, :test, :production, :travis, :dm do
  gem 'mysql2'
  gem 'dm-core'        , DM_VERSION, :git => "#{DATAMAPPER}/dm-core.git"
  gem 'dm-mysql-adapter'     , DM_VERSION, :git => "#{DATAMAPPER}/dm-mysql-adapter.git"
  gem 'dm-do-adapter'     , DM_VERSION, :git => "#{DATAMAPPER}/dm-do-adapter.git"
    
  gem 'dm-migrations'        , DM_VERSION, :git => "#{DATAMAPPER}/dm-migrations.git"
  # gem 'dm-types'            , DM_VERSION#, git: "git://github.com/datamapper/dm-types.git"
  gem 'dm-validations'       , DM_VERSION2, :git => "#{DATAMAPPER}/dm-validations.git"
  gem 'dm-constraints'      , DM_VERSION, :git => "#{DATAMAPPER}/dm-constraints.git"
  # gem 'dm-transactions'    , DM_VERSION
  gem 'dm-aggregates'        , DM_VERSION, :git => "#{DATAMAPPER}/dm-aggregates.git"
  # gem 'dm-timestamps'        , DM_VERSION
  # gem 'dm-observer'          , DM_VERSION
end

group :dm_test do
  gem "nokogiri"
end     

group :development, :test, :production, :travis, :app do
  gem 'activesupport',       :require => 'active_support'
  gem 'actionpack',          :require => 'action_pack'
  gem 'actionmailer',        :require => 'action_mailer'
  gem 'railties',            :require => 'rails'



  gem 'dm-rails', DM_VERSION, git: "#{DATAMAPPER}/dm-rails.git"

  gem 'dm-active_model', DM_VERSION, git: "#{DATAMAPPER}/dm-active_model.git"
  
  gem 'tzinfo'

  gem "haml"
  gem "sass"

  gem "tilt"
  gem 'coffee-script'
  
  gem "mechanize"
  gem "resque"


  gem "sorcery"

  gem "voidtools", git: "git://github.com/makevoid/voidtools"
  
  

end


group :development do
  gem "thin"
end

group :development, :no_ci, :production do
  gem 'jquery-rails'

  # gem 'thin'
  gem "url2png"
  gem 'newrelic_rpm'
  gem "exception_notification", :git => "git://github.com/rails/exception_notification"
  gem "unicorn"

  gem 'compass', :git => 'git://github.com/chriseppstein/compass.git'#, :branch => 'rails31'

  gem "pry"
  gem "guard"
  gem 'capistrano'
end

group :development, :test, :travis do
  gem "rspec-rails", "~> 2.6"
  # gem "jasmine"
end

group :development, :test, :no_ci do
  # gem "spork", git: "git://github.com/timcharper/spork.git" # fix deprecation of Gem.latest_load_paths 
end

group :test, :no_ci do
  gem "factory_girl_rails"
  gem "capybara"
  gem "fakeweb"
  gem "vcr"
end

# Gems used only for assets and not required
# in production environments by default.
group :assets, :no_ci do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"#, git: "git://github.com/rails/coffee-rails.git"
  gem 'uglifier'
  # gem "compass"
  
end


# ???
# gem "bson", "~> 1.4.1"

# web servers
# gem 'unicorn'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
