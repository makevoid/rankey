require 'active_support/inflector'
class String
  include ActiveSupport::Inflector
end


guard 'livereload' do
  watch(%r{.+\.(rb|ru)})
  watch(%r{app/(models|controllers|mailers)/.+\.(rb|yml|haml)})
  watch(%r{app/views/\w+/.+\.(html|erb|haml)})  
  watch(%r{app/assets/javascripts/\w+/.+\.(coffee)})
  watch(%r{app/assets/javascripts/.+\.(coffee)})  
  watch(%r{(app|public|spec)/javascripts/(^spec)/.+\.(coffee)})
  watch(%r{(app|public|spec)/javascripts/.+\.(coffee)})
  watch(%r{public/stylesheets/.+\.(css)})
  watch(%r{public/stylesheets/sass/.+\.(sass)})
  watch(%r{app/assets/stylesheets/sass/.+\.(sass)})
end


# guard 'spork' do
#   watch('config/application.rb')
#   watch('config/environment.rb')
#   watch(%r{^config/environments/.+\.rb$})
#   watch(%r{^config/initializers/.+\.rb$})
#   watch('spec/spec_helper.rb')
# end

# guard 'rspec', :cli => "--drb" do
#   
#   watch('spec/spec_helper.rb')                        { "spec" }
#   watch('config/routes.rb')                           { "spec/routing" }
#   watch('app/controllers/application_controller.rb')  { "spec/controllers" }
#   watch(%r{^spec/.+_spec\.rb$})
#   watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
#   watch(%r{^lib/(.+)\.rb$})                           { |m| "spec/lib/#{m[1]}_spec.rb" }
#   watch(%r{^app/controllers/(.+)_(controller)\.rb$})  { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/acceptance/#{m[1]}_spec.rb"] }
#   
#   watch(%r{^app/views/(.+)/.*\.(erb|haml)$}) { |m| "spec/requests/#{m[1]}_spec.rb" }
#   watch(%r{^app/controllers/(.+)_(controller)\.rb$}) { |m| "spec/requests/#{m[1]}_spec.rb" }
#   watch(%r{^app/models/\w+/(.+)\.rb$}) { |m| "spec/requests/#{m[1].pluralize}_spec.rb" }
#   watch('app/controllers/application_controller.rb')  { "spec/requests" }
# end

guard 'coffeescript', :input => 'spec/javascripts'

