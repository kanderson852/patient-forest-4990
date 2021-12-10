Rails.application.routes.draw do
  get '/movies/:id', to: 'movies#show'
  get '/studios', to: 'studios#index'
end
