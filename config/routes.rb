Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :users do
    resources :sleep_records

    get :view_follower_sleep_records, to: 'users#view_follower_sleep_records'
    post :follow, to: 'users#follow'
    delete :unfollow, to: 'users#unfollow'
  end

  # Defines the root path route ("/")
  # root "articles#index"
end
