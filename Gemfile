source 'http://rubygems.org'

gem 'activesupport',       :require => 'active_support'
gem 'actionpack',          :require => 'action_pack'
gem 'actionmailer',        :require => 'action_mailer'
gem 'railties',            :require => 'rails'

gem 'mysql2'

DM_VERSION    = '~> 1.2.0.rc1'

#gem 'dm-rails', "1.1.0" # git: "https://github.com/datamapper/dm-rails.git"

gem 'dm-active_model', DM_VERSION, git: "git://github.com/datamapper/dm-active_model.git"
gem 'dm-rails', DM_VERSION, git: "git://github.com/datamapper/dm-rails.git"
gem 'dm-mysql-adapter'     , DM_VERSION
gem 'dm-migrations'        , DM_VERSION
gem 'dm-types'            , DM_VERSION, git: "git://github.com/datamapper/dm-types.git"
gem 'dm-validations'       , DM_VERSION
#gem 'dm-constraints'      , DM_VERSION
# gem 'dm-transactions'    , DM_VERSION
gem 'dm-aggregates'        , DM_VERSION
gem 'dm-timestamps'        , DM_VERSION
gem 'dm-observer'          , DM_VERSION

# gem 'dm-core'       

gem 'tzinfo'

gem "haml"
gem "sass"

# gem "resque"

gem 'newrelic_rpm'
gem "voidtools", git: "git://github.com/makevoid/voidtools"
gem "exception_notification", :git => "git://github.com/rails/exception_notification"

gem 'jquery-rails'
gem 'capistrano'

group :development, :test do
  gem "rspec-rails", "~> 2.6"
  gem "jasmine", group: [:development, :test]
  gem "spork"
end

group :test do
  gem "factory_girl_rails"
  gem "capybara"
  gem "fakeweb"
  gem "vcr"
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"#, git: "git://github.com/rails/coffee-rails.git"
  gem 'uglifier'
end


# web servers
# gem 'unicorn'
gem 'thin'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
