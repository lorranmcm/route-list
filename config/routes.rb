Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  patch '/projects/:project_id/tasks/:id', to: 'tasks#update', as: :task_update
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :projects, only: [:index] do
    resources :tasks, only: [:create, :show, :index]

  end
end
