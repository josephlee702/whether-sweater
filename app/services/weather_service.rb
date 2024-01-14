class WeatherService
  def self.conn
    Faraday.new(url: 'http://api.weatherapi.com/v1/forecast.json')
  end
  
  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end