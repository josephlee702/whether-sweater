class DirectionsService
  def self.conn
    Faraday.new(url: 'https://www.mapquestapi.com/directions/v2/route')
  end
  
  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_route(from, to, api_key)
    get_url("?key=#{api_key}&from=#{from}&to=#{to}")
  end
end