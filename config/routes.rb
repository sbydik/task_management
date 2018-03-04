Rails.application.routes.draw do
  resources :tasks
  match '/update_task_status' => 'tasks#update_task_status', via: [:post]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
