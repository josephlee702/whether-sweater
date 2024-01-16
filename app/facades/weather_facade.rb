class WeatherFacade
  def self.get_forecast(lat, lon)
   service = WeatherService.get_forecast(lat, lon)
   
  end
end
