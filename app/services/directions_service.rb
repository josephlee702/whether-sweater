class DirectionsService
  def self.conn
    Faraday.new(url: 'https://www.mapquestapi.com/directions/v2/route')
  end
  
  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end