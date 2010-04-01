Statr::Application.routes.draw do |map|

  resources :users do
    resources :mentions
    
    member do
      post :follow, :unfollow
    end
  end
  resources :messages

  resource :session

  match 'login' => 'sessions#new', :as => :login
  match 'logout' => 'sessions#destroy', :as => :logout
  
  root :to => "messages#index"
end
