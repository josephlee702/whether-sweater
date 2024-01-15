Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      get "/forecast", to: "forecasts#show"
      post "/users", to: "users#create"
      post "/sessions", to: "users#log_in"
      # post "/road_trip", to: ""
    end
  end
end
