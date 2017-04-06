Rails.application.routes.draw do

  root                                 to: 'sessions#show'
  get     '/auth/:provider/callback',  to: 'sessions#create'
  delete '/logout',                    to: 'sessions#destroy'
  get   '/sign_in_with_census',        to: 'sessions#new'

  # namespace :admin do
  #   resources :census_users, only: [:index]
  #   resources :weeks
  #   resources :categories
  # end

  resources :users, only: [] do
    resources :goals
  end

end
