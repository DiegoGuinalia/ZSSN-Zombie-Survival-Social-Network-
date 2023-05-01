Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: proc { [404, {}, ["Not found."]] }

  namespace :api do
    namespace :v1 do
      post '/users/create', to: 'users#create'
      put 'users/mark_as_infected', to: 'users#mark_as_infected'
      put '/users/update_user_items', to: 'users#update_user_items'
      delete '/users/delete_user_items', to: 'users#delete_user_items'
    end
  end
end
