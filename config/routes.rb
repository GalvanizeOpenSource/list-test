Rails.application.routes.draw do
  root 'todo_lists#index'

  resources :todo_lists do
    resources :todo_items
  end

  scope :api, module: 'api', as: :api do
    resources :todo_item_state, only: [:update]
    resources :due_items, only: [:index]
    resources :todo_items, only: [:create]
  end
end
