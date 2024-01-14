class WeatherFacade
  def self.get_forecast(lat, lon)
    WeatherService.get_url("?key=#{Rails.application.credentials.weather_api[:key]}&q=#{lat},#{lon}&aqi=no&days=5")
  end
end
