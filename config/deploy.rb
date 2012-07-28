set :application, "rankey"


set :domain,      "rankey.mkvd.net"

# set :repository,  "svn://#{domain}/svn/#{application}"


set :apps,        "/www"
set :deploy_to,   "#{apps}/#{application}"


set :use_sudo,    false
set :user,        "www-data"


#default_run_options[:pty] = true  # Must be set for the password prompt from git to work
set :repository, "git://github.com/makevoid/#{application}.git"  # pub
# private
# set :repository, "git@github.com:makevoid/cappiello.git"  # Your clone URL
set :scm, "git"
# needed?
set :branch, "master"
set :password,  File.read(File.expand_path "~/.password").strip
set :scm_passphrase, password  # The deploy user's password

# ssh_options[:forward_agent] = true
#set :deploy_via, :remote_cache


#
# set :scm_username, "makevoid"
#
# #File.read("/home/www-data/.password").strip
# set :password, File.read("/Users/makevoid/.password").strip
# set :scm_password, password
# # set :deploy_via, :copy
# # set :copy_exclude, [".git", "db", "nbproject", "public/images/cars"]
#

role :app, domain
role :web, domain
role :db,  domain, :primary => true


after :deploy, "deploy:create_symlinks"
after :deploy, "deploy:create_database_yml"
# after :deploy, "deploy:create_mailer_init"
after :deploy, "deploy:newrelic_secret"

after :deploy, "deploy:cleanup"
after :deploy, "chmod:entire"
after :deploy, "deploy:link_logo"
after :deploy, "deploy:compile_assets"


namespace :deploy do

  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end

  desc "Link logo"
  task :link_logo, :roles => :app do
    # optional
    groups = "#{current_path}/public/images/groups"
    run "mkdir -p #{groups}; cp /home/www-data/.rankey_logo.png #{groups}/win2win.png "
  end

  desc "Compile assets"
  task :compile_assets, :roles => :app do
    run "cd #{current_path}; rake assets:precompile"
  end

  desc "Setup newrelic license key"
  task :newrelic_secret do
    newrelic_key = File.read(File.expand_path '~/Dropbox/.newrelic').strip
    run "ruby -e \"path = '#{current_path}/config'; db_yaml = File.read(path+'/newrelic.yml'); File.open(path+'/newrelic.yml', 'w'){ |f| f.write db_yaml.gsub(/LICENSE_KEY/, '#{newrelic_key}') }\""
  end


  desc "Create symlinks (managing server)"
  task :create_symlinks do
    run "cd #{current_path}/public; ln -s #{deploy_to}/shared/pdf pdf"
    run "mkdir -p #{current_path}/tmp"
  end

  desc "Create database yml"
  task :create_database_yml do
    run "ruby -e \"path = '#{current_path}/config'; db_yaml = File.read(path+'/database.yml'); File.open(path+'/database.yml', 'w'){ |f| f.write db_yaml.gsub(/secret/, '#{password}') }\""
    # upload "config/database.yml", "#{current_path}/config/database.yml", via: :scp

  end


  desc "Create mailer initializer"
  task :create_mailer_init do
    run "ruby -e \"path = '#{current_path}/config/initializers'; db_yaml = File.read(path+'/mail.rb'); File.open(path+'/mail.rb', 'w'){ |f| f.write db_yaml.gsub(/secret/, '#{password.gsub(/33/, '')}') }\""
    # upload "config/database.yml", "#{current_path}/config/database.yml", via: :scp

  end


end

namespace :chmod do
  desc "chmod entire dir"
  task :entire do
    run "cd #{current_path}; chown www-data:www-data -R *"
  end
end




def path
  File.expand_path File.dirname(__FILE__)
end


namespace :bundler do
  task :create_symlink, :roles => :app do
    shared_dir = File.join(shared_path, 'bundle')
    release_dir = File.join(current_release, '.bundle')
    run("mkdir -p #{shared_dir} && ln -s #{shared_dir} #{release_dir}")
  end

  task :bundle_new_release, :roles => :app do
    bundler.create_symlink
    run "cd #{release_path} && bundle install --without test"
  end

  task :lock, :roles => :app do
    run "cd #{current_release} && bundle lock;"
  end

  task :unlock, :roles => :app do
    run "cd #{current_release} && bundle unlock;"
  end
end

# HOOKS
after "deploy:update_code" do
  bundler.bundle_new_release
  # ...
end



namespace :db do
  desc "Create database"
  task :create do
    run "mysql -u root --password=#{password} -e 'CREATE DATABASE IF NOT EXISTS #{application}_production;'"
  end

  desc "Seed database"
  task :seeds do
    run "cd #{current_path}; RAILS_ENV=production rake db:seeds"
  end

  desc "Send the local db to production server"
  task :toprod do
    # `rake db:seeds`
    `mysqldump -u root #{application}_development > db/#{application}_development.sql`
    upload "db/#{application}_development.sql", "#{current_path}/db", via: :scp
    run "mysql -u root --password=#{password} #{application}_production < #{current_path}/db/#{application}_development.sql"
  end

  desc "Get the remote copy of production db"
  task :todev do
    run "mysqldump -u root --password=#{password} #{application}_production > #{current_path}/db/#{application}_production.sql"
    download "#{current_path}/db/#{application}_production.sql", "db/#{application}_production.sql"
    local_path = `pwd`.strip
    `mysql -u root #{application}_development < #{local_path}/db/#{application}_production.sql`

    t = Time.now
    file = "#{application}_production_#{t.strftime("%Y_%m_%d")}.sql"
    `mv db/#{application}_production.sql db/#{file}`

    if ENV["BACKUP"] != "" || !ENV["BACKUP"].nil?
      `cp db/#{file} ~/db_backups/`
      puts "Backup saved on ~/db_backups/#{file}"
    end
  end
end
