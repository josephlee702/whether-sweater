class DirectionsFacade
  def self.get_route(from, to, api_key)
    coordinates = WeatherFacade.get_lat_lon(to)
    forecast = WeatherService.get_forecast(coordinates.first, coordinates.second)

    directions_data = DirectionsService.get_route(from, to, api_key)
    directions = directions_data[:route]

    format_directions(forecast, directions, from, to)
  end

  private

  def self.format_directions(forecast, directions, from, to)
    {
      "data": {
        "id": nil,
        "type": "road_trip",
        "attributes": {
          "start_city": from,
          "end_city": to,
          "travel_time": self.travel_time_from_seconds(directions, directions[:realTime]), 
          "weather_at_eta": weather_at_eta(directions, forecast)
        }
      }
    }
  end

  private

  def self.travel_time_from_seconds(directions, seconds)
    if directions[:routeError]
      return "impossible"
    else
      hours = seconds / 3600
      minutes = (seconds % 3600) / 60
      seconds = seconds % 60

      "%02d:%02d:%02d" % [hours, minutes, seconds]
    end
  end

  def self.weather_at_eta(directions, forecast)
    if directions[:routeError]
      nil
    else
      {
        "datetime": datetime_at_eta(directions),
        "temperature": temperature_at_eta(forecast, directions),
        "condition": condition_at_eta(forecast, directions)
      }
    end
  end

  def self.datetime_at_eta(directions)
    current_time = Time.now
    seconds_to_add = directions[:realTime]

    time = current_time + seconds_to_add
    formatted_rounded_time = time.strftime("%Y-%m-%d %H:%M")
  end

  def self.temperature_at_eta(forecast, directions)
    eta = datetime_at_eta(directions)
    eta_time = Time.parse(eta)
  
    rounded_time = Time.at((eta_time.to_f / 3600).round * 3600)
    formatted_rounded_time = rounded_time.strftime("%Y-%m-%d %H:%M")
    only_date = DateTime.strptime(formatted_rounded_time, "%Y-%m-%d %H:%M")
    eta_date = only_date.strftime("%Y-%m-%d")
    #eta_date is "2024-01-20"
    forecast[:forecast][:forecastday].each do |day|
      if day[:date] == eta_date
        day[:hour].each do |hour|
          return hour[:temp_f] if formatted_rounded_time == hour[:time]
        end
      end
    end
  end
  
  def self.condition_at_eta(forecast, directions)
    eta = datetime_at_eta(directions)
    eta_time = Time.parse(eta)
  
    rounded_time = Time.at((eta_time.to_f / 3600).round * 3600)
    formatted_rounded_time = rounded_time.strftime("%Y-%m-%d %H:%M")
    only_date = DateTime.strptime(formatted_rounded_time, "%Y-%m-%d %H:%M")
    eta_date = only_date.strftime("%Y-%m-%d")
    #eta_date is "2024-01-20"
    forecast[:forecast][:forecastday].each do |day|
      if day[:date] == eta_date
        day[:hour].each do |hour|
          return hour[:condition][:text] if formatted_rounded_time == hour[:time]
        end
      end
    end
  end
end
