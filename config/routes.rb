Rails.application.routes.draw do

  root                                 to: 'sessions#show'
  get     '/auth/:provider/callback',  to: 'sessions#create'
  delete '/logout',                    to: 'sessions#destroy'
  get   '/sign_in_with_github',        to: 'sessions#new'

  namespace :admin do
  #   resources :census_users, only: [:index]
     resources :weeks, only: [:new, :create, :edit, :update]
     resources :dashboard, only: [:index]
     resources :winners, only: [:index, :new, :create, :show]
   end

  namespace :user do
    resources :goals
  end
  put 'goals/:id/inc', to: 'goals#increment', as: 'inc_goal'

  resources :goals, only: [:index]
  resources :weeks, only: [:index, :create]
  resources :users, only: [:edit, :update]
  resources :mods, only: [:index]
end
