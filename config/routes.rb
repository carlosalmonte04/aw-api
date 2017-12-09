Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get 'csv_parser', to: 'csv_parsers#index'
      post 'csv_parser', to: 'csv_parsers#create'
    end
  end
end
