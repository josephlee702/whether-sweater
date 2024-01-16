class DirectionsFacade
  def self.get_route(from, to, api_key)
    DirectionsService.get_url("?key=#{api_key}&from=#{from}&to=#{to}")
  end
end
