Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      get "/forecast", to: "locations#show"
    end
    namespace :v1 do
      get "/munchies", to: "munchies#show"
    end
  end
end
