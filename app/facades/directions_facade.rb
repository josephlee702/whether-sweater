class DirectionsFacade
  def self.get_route(location1, location2)
    DirectionsService.get_url("?key=#{Rails.application.credentials.mapquest_api[:key]}&from=#{location1}&to=#{location2}")
  end
end
