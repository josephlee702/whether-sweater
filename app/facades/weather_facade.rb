class WeatherFacade
  def self.get_forecast(location)
    coordinates = MapquestFacade.get_lat_lon(location)
    response = WeatherService.get_forecast(coordinates.first, coordinates.second)

    build_forecast_data(response)
  end

  private 

  def self.build_forecast_data(response)
    {
      "data": {
        "id": nil,
        "type": "forecast",
        "attributes": {
          "current_weather": format_current_weather(response[:current]),
          "daily_weather": format_daily_weather(response[:forecast][:forecastday]),
          "hourly_weather": format_hourly_weather(response[:forecast][:forecastday].first[:hour])
        }
      } 
    }
  end

  def self.format_current_weather(current)
    {
      "last_updated": current[:last_updated],
      "temperature": current[:temp_f],
      "feels_like": current[:feelslike_f],
      "humidity,": current[:humidity],
      "uvi": current[:uv],
      "visibility_miles": current[:vis_miles],
      "condition": current[:condition][:text],
      "icon": current[:condition][:icon] 
    }
  end

  def self.format_daily_weather(days)
    days.map do |day|
      {
        "date": day[:date],
        "sunrise": day[:astro][:sunrise],
        "sunset": day[:astro][:sunset],
        "max_temp": day[:day][:maxtemp_f],
        "min_temp": day[:day][:mintemp_f],
        "condition": day[:day][:condition][:text],
        "icon": day[:day][:condition][:icon]
      }
    end
  end

  def self.format_hourly_weather(hours)
    hours.map do |hour|
      {
        "time": hour[:time],
        "temperature": hour[:temp_f],
        "conditions": hour[:condition][:text],
        "icon": hour[:condition][:icon]
      }
    end
  end
end
