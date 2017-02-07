Rails.application.routes.draw do

  namespace :admin do
    root 'application#index'

    resources :projects, only: [:new, :create, :destroy]

    resources :users do
      member do
        patch :archive
      end
    end

    resources :states, only: [:index, :new, :create]
  end

  devise_for :users

  root "projects#index"

  resources :projects, only: [:index, :show, :edit, :update] do
    resources :tickets
  end

  # a separate non-nested resource for your tickets, and then a nested resource under that for your comments
  # only care about the ticket, so you can use ticket_comments_path instead.
  resources :tickets, only: [] do
    resources :comments, only: [:create]
  end

  resources :attachments, only: [:show, :new]
end
