Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: proc { [404, {}, ["Not found."]] }

  namespace :api do
    namespace :v1 do
      #USERS
      post '/users/create', to: 'users#create'
      post '/users/trade_user_items', to: 'users#trade_user_items'
      put 'users/mark_as_infected', to: 'users#mark_as_infected'
      put '/users/update_user_items', to: 'users#update_user_items'
      delete '/users/delete_user_items', to: 'users#delete_user_items'

      #REPORTS
      get 'reports/infected_percentage', to: 'reports#infected_percentage'
      get 'reports/not_infected_percentage', to: 'reports#not_infected_percentage'
      get 'reports/lost_points', to: 'reports#lost_points'
      get 'reports/average_items_per_user', to: 'reports#average_items_per_user'
    end
  end
end
