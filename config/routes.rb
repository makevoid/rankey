Rankey::Application.routes.draw do
  
  get "/sites",                     to: "sites#index"
  get "/sites/:site_id/keys",       to: "keys#index"
  get "/keys/:key_id/positions",    to: "positions#index"
  
  root :to => 'rankey#show'

end
