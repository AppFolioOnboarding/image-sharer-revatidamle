Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/tagged', to: 'images#tagged', as: :tagged
  root 'images#index'
  resources :images
end
