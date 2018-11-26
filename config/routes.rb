Rails.application.routes.draw do

  resources :pictures do
    resources :comments
    collection do
      post :confirm
    end
  end
  root to: 'tops#index'

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :favorites, only: [:create, :destroy]

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
