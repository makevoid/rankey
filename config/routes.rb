Rankey::Application.routes.draw do

  backbone = 'rankey#show'
  
  get "/sites/new", to: backbone
  get "/sites",                       to: "sites#index"
  
  get "/sites/:site_id",              to: "sites#show"
  get "/sites/:site_id/image",        to: "sites#image"
  get "/sites/:site_id/keys_src",     to: "sites#keys"
  get "/sites/:site_id/keys",         to: "keys#index"
  get "/sites/:site_id/keys/history", to: "keys#history"
  get "/keys/:key_id/positions",      to: "positions#index"
  
  
  root to: backbone
  get "/not_found", to: backbone
  
  
  get "/login", to: backbone
  get "/logout", to: backbone
  
  post "/sessions", to: "sessions#create"
  delete "/sessions", to: "sessions#destroy"
  
  post "/sites", to: "sites#create"

  post "/keys",         to: "keys#keys"
  put "/sites/:site_id/keys_src",     to: "sites#update_keys"
  
  delete "/sites/:site_id",  to: "sites#destroy"
  
  # get "/sites", to: backbone
  # get "/sites/:site_id", to: backbone
end
