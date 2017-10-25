Rails.application.routes.draw do

  resources :wikis do
    resources :pages, except: [:index]
  end

  resources :charges, only: [:new, :create]
  devise_for :users
  get 'welcome/index'

  get 'welcome/about'
  get 'charges/downgrade'
  put 'charges/demote'

  root 'welcome#index'
end
