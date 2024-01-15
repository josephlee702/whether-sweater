class DirectionsSerializer
  def self.format_directions(directions)
    {
      "data": {
        "id": nil,
        "type": "road_trip",
        "attributes": {
          "start_city": "#{directions[:route][:locations].first[:adminArea5]}, #{directions[:route][:locations].first[:adminArea3]}",
          "end_city": "#{directions[:route][:locations].second[:adminArea5]}, #{directions[:route][:locations].first[:adminArea3]}",
          "travel_time": self.travel_time_from_seconds(directions[:route][:realTime]), 
          "weather_at_eta": {
            "datetime": WeatherFacade.get_forecast,
            "temperature": 44.2,
            "condition": "Cloudy with a chance of meatballs"
          }
        }
      }
    }
  end

  private

  def self.travel_time_from_seconds(seconds)
    hours = seconds / 3600
    minutes = (seconds % 3600) / 60
    seconds = seconds % 60

    "%02d:%02d:%02d" % [hours, minutes, seconds]
  end

  def datetime
    WeatherFacade.get_forecast
  end
end
