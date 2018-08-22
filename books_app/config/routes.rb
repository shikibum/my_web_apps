# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  get 'books/index'
  resources :books

  scope '/:locale' do
    resources :books
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
