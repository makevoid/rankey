Rankey::Application.routes.draw do
  
  get "/sites",                       to: "sites#index"
  get "/sites/:site_id",              to: "sites#show"
  get "/sites/:site_id/image",        to: "sites#image"
  get "/sites/:site_id/keys",         to: "keys#index"
  get "/sites/:site_id/keys/history", to: "keys#history"
  get "/keys/:key_id/positions",      to: "positions#index"
  
  backbone = 'rankey#show'
  
  root to: backbone
  get "/not_found", to: backbone
  
  
  get "/login", to: backbone
  
  post "/sessions", to: "sessions#create"
  
  # get "/sites", to: backbone
  # get "/sites/:site_id", to: backbone
end
