Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources 'article', only: [:index]
  get "/search", to: "search#index"
  post 'article/search', to: 'article#search'
  root 'article#index'
end
