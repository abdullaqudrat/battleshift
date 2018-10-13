Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:index, :show, :edit, :update, :create]
	get '/users/:id/activate', to: 'users#activate'
  root to: 'welcome#index'
  get '/register', to: 'users#new'
  post '/notification' => 'notification#create'
  get '/dashboard', to: 'welcome#show'
	get '/login'     => 'sessions#new'
	post '/login'    => 'sessions#create'
	delete '/logout' => 'sessions#destroy'
  namespace :api do
    namespace :v1 do
      resources :games, only: [:show] do
        post "/shots", to: "games/shots#create"
      end

      resources :users, only: [:index, :show, :update]
    end
  end
end
