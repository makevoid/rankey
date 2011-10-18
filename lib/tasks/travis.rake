namespace :travis do
  namespace :db do
    task :create do
      `mysql -e "CREATE DATABASE rankey_travis"`
    end
  end
end