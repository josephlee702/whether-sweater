Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      get "/forecast", to: "forecasts#show"
    end
  end
end
