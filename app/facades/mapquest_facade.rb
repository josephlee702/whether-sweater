class MapquestFacade
  def self.get_lat_lon(location)
    data = MapquestService.get_lat_lon(location)
    require 'pry'; binding.pry
    coordinates = "#{data[:results].first[:locations].first[:latLng][:lat]}, ##{data[:results].first[:locations].first[:latLng][:lng]}"
    split_coordinates = coordinates.split(",")
  end
end