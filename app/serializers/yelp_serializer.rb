class YelpSerializer
  def self.format_restaurant(restaurant)
    {
      "data": {
        "id": nil,
        "type": "munchie",
        "attributes": {
          "destination_city": city_state(restaurant),
          "forecast": {
            "summary": WeatherFacade.get_forecast(restaurant[:coordinates][:latitude], restaurant[:coordinates][:longitude])[:current][:condition][:text],
            "temperature": WeatherFacade.get_forecast(restaurant[:coordinates][:latitude], restaurant[:coordinates][:longitude])[:current][:temp_f]
          },
          "restaurant": {
            "name": restaurant[:name],
            "address": format_address(restaurant[:location][:display_address]),
            "rating": restaurant[:rating],
            "reviews": restaurant[:review_count] 
          }
        }
      } 
    }
  end
  
  private

  def self.city_state(restaurant)
    "#{restaurant[:location][:city]},#{restaurant[:location][:state]}"
  end

  def self.format_address(address)
    address.join(', ')
  end
end
