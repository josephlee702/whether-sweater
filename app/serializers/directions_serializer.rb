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
            "datetime": WeatherFacade.get_forecast(directions[:route][:legs].first[:maneuvers].last[:startPoint][:lat], directions[:route][:legs].first[:maneuvers].last[:startPoint][:lng])[:location][:localtime],
            "temperature": WeatherFacade.get_forecast(directions[:route][:legs].first[:maneuvers].last[:startPoint][:lat], directions[:route][:legs].first[:maneuvers].last[:startPoint][:lng])[:current][:temp_f],
            "condition": WeatherFacade.get_forecast(directions[:route][:legs].first[:maneuvers].last[:startPoint][:lat], directions[:route][:legs].first[:maneuvers].last[:startPoint][:lng])[:forecast][:forecastday].first[:day][:condition][:text]
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

  # def lat_lon_eta(coordinates)
  #   "#{coordinates[:lat]}, #{coordinates[:lng]}"
  # end
end
