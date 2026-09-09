Rails.application.routes.draw do
  root "home#index"
  get "up" => "rails/health#show", as: :rails_health_check

  get "user/login", to: "user#login"
  post "user/login", to: "user#create_login"
  get "user/logout", to: "user#logout", as: :logout 

  get "user/cadastrar", to: "user#cadastrar"
  post "user/cadastrar", to: "user#create_cadastrar"

  get "/admin", to: "admin#index"
  get "/admin/index", to: "admin#index"

  get "produto/index", to: "produto#index", as: :index_produto
  get "produto/cardapio", to: "produto#cardapio", as: :cardapio_produto
  get "produto/novidades", to: "produto#novidades", as: :novidades_produto

  get "produto/new", to: "produto#new", as: :new_produto
  post "produto/new", to: "produto#create"
  get "produto/:id/edit", to: "produto#edit", as: :edit_produto
  patch "produto/:id", to: "produto#update", as: :produto_update
  put "produto/:id", to: "produto#update"
  get "produto/:id", to: "produto#show", as: :show_produto
  delete "produto/:id", to: "produto#destroy", as: :delete_produto
end
