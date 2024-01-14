class MapquestService
  def self.conn
    Faraday.new(url: 'https://www.mapquestapi.com/geocoding/v1/address')
  end
  
  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end