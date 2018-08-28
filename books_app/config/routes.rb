# frozen_string_literal: true

Rails.application.routes.draw do
<<<<<<< Updated upstream
  devise_for :users
=======
  root to: 'books#index'
  get 'users/new'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks' 
  }
>>>>>>> Stashed changes
  get 'books/index'
  resources :books

  scope '/:locale' do
    resources :books
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
