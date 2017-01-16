Rails.application.routes.draw do
  devise_for :clients

  root 'home#index'

  resources :chats, only: [:new, :create, :show, :index]

  mount ActionCable.server => '/cable'
end
