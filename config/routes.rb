Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :me, only: [] do
    collection do
      get :sleep_records
      post :sleep_records, to: 'me#add_sleep_record'
      put :"sleep_records/:id", to: 'me#update_sleep_record'

      get :followers
      get :"followers/:user_id/sleep_records", to: 'me#view_follower_sleep_records'
      get :following_users
      put :"follow/:user_id", to: 'me#follow'
      put :"unfollow/:user_id", to: 'me#unfollow'
    end
  end

  resources :users, only: [:index]

  # Defines the root path route ("/")
  root "application#index"
end
