Rails.application.routes.draw do
  resources :pictures do
    collection do
      post :confirm
    end
  end
  root to: 'pictures#index'
end
