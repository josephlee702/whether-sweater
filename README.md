# README

Learning goals:
- Expose an API that aggregates data from multiple external APIs
- Expose an API that requires an authentication token
- Expose an API for CRUD functionality
- Determine completion criteria based on the needs of other developers
- Test both API consumption and exposure, making use of at least one mocking tool (VCR, Webmock, etc). 

How to clone this repo to your local machine:
- Go to your terminal, go to the desired directory, and type in "git clone <https://github.com/josephlee702/whether-sweater>". 
- Press enter, and now you should have a copy of the repo in your directory!

Where to get your own API keys:
- Mapquest: Sign up for an account at https://developer.mapquest.com/documentation/ and receive an API key.
- WeatherAPI: Go to https://www.weatherapi.com/docs/ and follow the instructions under "Getting Started".

Happy Path Endpoint Usage:
*** Make sure you have signed up for api keys for both the mapquest API and the WeatherAPI! ***
- There are four endpoints in this application that you can reach out to:
  1) Landing Page:
     Endpoint: get "/forecast"
    - A successful request looks like:
    
      GET /api/v0/forecast?location=cincinatti,oh
      Content-Type: application/json
      Accept: application/json

      You will need a `location` parameter, an `aqi` parameter, and a `days` parameter. 
        - The `location` parameter refers to the location at which you wish to see the forecast for.
        - The `aqi` refers to an air quality index, and accepts a 'yes' or 'no' value.
        - The `days` parameter refers to how many days you wish to see a weather forecast for. The value is accepted as an integer.

  2) User Account Creation
     Endpoint: post "/users"

    - A successful request looks like:
    
      POST /api/v0/users
      Content-Type: application/json
      Accept: application/json

      JSON Payload to send with the request:
      {
        "email": "whatever@example.com",
        "password": "password",
        "password_confirmation": "password"
      }

      You will need a `email` parameter, an `password` parameter, and a `password_confirmation` parameter. 
        - The `email` parameter refers to the email you are signing up with.
        - The `password` is the password you wish to set for your account.
        - The `password_confirmation` should match the `password` parameter *exactly*. Otherwise, your account will not be created.

  3) Existing User Log In:
     Endpoint: post "/sessions"

     - A successful request looks like:
    
      POST /api/v0/sessions
      Content-Type: application/json
      Accept: application/json

      JSON Payload to send with the request:
      {
        "email": "whatever@example.com",
        "password": "password"
      }

      You will need a `email` parameter and a `password` parameter.
        - The `email` parameter refers to the email you are signed up with.
        - The `password` is the password associated with the account.

  4) Road Trip:
     Endpoint: post "/road_trip"

     - A successful request looks like:
    
      POST /api/v0/road_trip
      Content-Type: application/json
      Accept: application/json

      JSON Payload to send with the request:
      {
        "origin": "Cincinatti,OH",
        "destination": "Chicago,IL",
        "api_key": "t1h2i3s4_i5s6_l7e8g9i10t11"
      }

      You will need an `origin` parameter, a `destination` parameter, and an `api_key` parameter.
        - The `origin` parameter refers to your starting location.
        - The `destination` is the location you wish to end your road trip at.
        - The `api_key` is the WeatherAPI key that you should have signed up for.

If you have any further questions, feel free to reach out to me at jlee230@turing.edu. I would be happy to answer any further questions for you.
