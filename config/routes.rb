Rails.application.routes.draw do
  resources :authors
  resources :books
  
  resources :authors do
    get 'books', to: 'authors#books_index'
  end
end
