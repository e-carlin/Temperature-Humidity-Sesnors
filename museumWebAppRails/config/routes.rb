Rails.application.routes.draw do
  resources :sensors
  resources :nodes
  #The website root
  root 'index#index'
  #root 'readings#index'

  #Readings routes
  resources :readings, only: [:index, :destroy, :show]

  resources :graphs

  #error log routes
  get '/logs' => 'index#logs'
 
  #for viewing the users
  #get '/users' => 'users#show'
  #get '/users' => 'users#destroy'
  #match 'Destroy' => 'users#destroy', via: :get 

  #api
   namespace :api do
     namespace :v1 do
       resources :readings, only: [:create]
     end
   end

# **** DONT touch anything below unless you are sure you know what you're doing ****
# Autogenerated by clearance gem
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  # need to use our users controller because we overwrote it
  #Mark - added show/destroy to be able to show all users
  resources :users, controller: "users", only: [:create, :show, :destroy, :index, :update, :edit] do
    resource :password,
      controller: "clearance/passwords",
      #This used to have :edit
      only: [:create, :update]
  end

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  #get "/sign_up" => "clearance/users#new", as: "sign_up"
  #Need to use our user controller for the sign up page
  get "/sign_up" => "users#new", as: "sign_up"
  #get "/edit_password" => "passwords#index", as: "edit"
  #get "/update_password/:email" => "users#update", :constraints => { :email => /.+@.+\..*/ }, as: "update_user_password"

  #Need to have the email be passed as a field
  get "/update_password/:email" => "users#edit", :constraints => { :email => /.+@.+\..*/ }, as: "update_user_password"

  #get "/update_password/:email" => "users#update", as: "update_user_password"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
