class MapquestFacade
  def self.get_lat_lon(location)
    MapquestService.get_url("?key=#{Rails.application.credentials.mapquest_api[:key]}&location=#{location}")
  end
end