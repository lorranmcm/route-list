Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/projects' => "projects#index", :as => :user_root

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :projects, only: [:index, :create, :update] do
    resources :tasks, only: [:create, :show, :index, :update]
  end
end
