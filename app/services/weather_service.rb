class SubscriptionService
  def self.conn
    Faraday.new(url: 'http://api.weatherapi.com/v1/forecast.json') do |faraday|
      faraday.headers['key'] = Rails.application.credentials.weather_api[:key]
    end
  end
  
  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_forecast(lat, lon)
    get_url("?q=#{lat},#{lon}&aqi=no&days=5")
  end
end