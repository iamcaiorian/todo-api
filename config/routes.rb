Rails.application.routes.draw do
  resources :tasks
  resources :todolists do
    get "tasks", on: :member
  end
  

  get "up" => "rails/health#show", as: :rails_health_check
end