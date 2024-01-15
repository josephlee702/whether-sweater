Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      get "/forecast", to: "locations#show"
      post "/users", to: "users#create"
      post "/sessions", to: "users#log_in"
    end
  end
end
