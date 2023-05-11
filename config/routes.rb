Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
  root "users#index"
  get "/users", to: "users#index"
  get "/users/:id", to: "users#show"
  get "/users/:user_id/posts", to: "posts#index"
  get "/users/:user_id/posts/:id", to: "posts#show"
  get "posts/new", to: "posts#new"
  post "posts/create", to: "posts#create"
  post "/users/:user_id/posts/:id/add_comment", to: "comments#add_comment"
  post "/users/:user_id/posts/:id/add_like", to: "likes#add_like"
end
