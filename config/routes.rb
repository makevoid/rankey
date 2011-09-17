Rankey::Application.routes.draw do
  
  get "/sites",                      to: "sites#index"
  get "/sites/:site_id",             to: "sites#show"
  get "/sites/:site_id/keys",        to: "keys#index"
  get "/keys/:key_id/positions",     to: "positions#index"
  
  backbone = 'rankey#show'
  
  root to: backbone
  
  # get "/sites", to: backbone
  # get "/sites/:site_id", to: backbone
end
