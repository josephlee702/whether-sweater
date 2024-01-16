class MapquestService
  def self.conn
    Faraday.new(url: 'https://www.mapquestapi.com/geocoding/v1/address') do |faraday|
      faraday.headers['key'] = Rails.application.credentials.mapquest_api[:key]
    end
  end
  
  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_lat_lon(location)
    get_url("?location=#{location}")
  end
end