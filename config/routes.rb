Rails.application.routes.draw do
  get 'evaluations/create'
  get 'evaluations/destroy'
  get 'relationships/create'
  get 'relationships/destroy'
  get 'favotites/create'
  get 'favotites/destroy'
  resource :sign_up, only: [:create]
  resource :sign_in, only: [:create]
  resources :users, only: [:update, :destroy]
  resources :items, only: [:index, :create, :update, :destroy, :show] do
    member do
      resource :purchases, only: [:create]
      resources :public_chats, only: [:create, :index]
      resources :public_chats, only: [:update, :destroy], param: :chat_id
      resources :favorites, only: [:create, :index, :destroy]
    end
  end
  get 'users/bought', to: 'users#my_bought'
  get 'users/my_item', to: 'users#my_item'
  post 'purchases/:id/private_chats', to: 'private_chats#create'
  get 'purchases/:id/private_chats', to: 'private_chats#index'
  resources :users do
    resource :relationships, only: [:create, :destroy]
    resource :evaluations, only: [:create] 
    get :follows, on: :member
    get :followers, on: :member
    get :evaluate, on: :member
    get :evaluated, on: :member
  end
end
