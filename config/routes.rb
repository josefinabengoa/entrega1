Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'movies#index'
  get 'movie', to: 'movies#show'
  get 'character', to: 'movies#character', as: 'character', constraints: { character_url: /.*/ }
  get 'starship', to: 'movies#starship', as: 'starship', constraints: { character_url: /.*/ }
  get 'planet', to: 'movies#planet', as: 'planet', constraints: { character_url: /.*/ }
end
