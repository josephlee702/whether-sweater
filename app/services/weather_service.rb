class WeatherService
  def self.conn
    Faraday.new(url: 'http://api.weatherapi.com/v1/forecast.json')
  end
  
  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_forecast(lat, lon)
    get_url("?key=#{Rails.application.credentials.weather_api[:key]}&q=#{lat},#{lon}&aqi=no&days=5")
  end
end