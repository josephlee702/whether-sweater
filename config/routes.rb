Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      get "/forecast", to: "locations#show"
      post "/users", to: "users#create"
    end
  end
end
