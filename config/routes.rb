Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  resources :users, only: [:index, :show, :edit, :update, :create]
	get '/users/:id/activate', to: 'users#activate'
  get '/register', to: 'users#new'

  root to: 'welcome#index'
  get '/dashboard', to: 'welcome#show'

  post '/notification' => 'notification#create'

	get '/login'     => 'sessions#new'
	post '/login'    => 'sessions#create'
	delete '/logout' => 'sessions#destroy'


  namespace :api do
    namespace :v1 do
      resources :games, only: [:show, :create] do
        post "/shots", to: "games/shots#create"
        post "/ships", to: "games/ships#create"
      end

      resources :users, only: [:index, :show, :update]
    end
  end
end
