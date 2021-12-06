Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/projects' => "projects#index", :as => :user_root

  patch '/projects/:project_id/tasks/:id', to: 'tasks#update', as: :task_update
  get '/projects/:project_id/tasks/new', to: 'tasks#new', as: :task_form
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :projects, only: [:index, :create, :update, :destroy] do
    resources :tasks, only: [:show, :create, :index, :destroy]
  end
  resources :users, only: [:index, :show]
end
