Rails.application.routes.draw do
    resources :users
    resources :clients
    post '/login', to: 'auth#login'
    get '/auth', to: 'auth#persist'
end
