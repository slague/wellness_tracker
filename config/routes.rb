Rails.application.routes.draw do
  root                             to: 'sessions#show'
  get  '/auth/:provider/callback', to: 'sessions#create'
  post '/logout',                  to: 'sessions#destroy'
  get  '/sign_in_with_census',     to: 'sessions#new'

  namespace :admin do
  #   resources :census_users, only: [:index]
     resources :weeks, only: [:index, :new, :create, :edit, :update]
  #   resources :categories
   end

  put '/users/:user_id/goals/:id/inc', to: 'goals#increment', as: 'inc_user_goal'

  resources :users, only: [] do
    resources :goals
  end

end
