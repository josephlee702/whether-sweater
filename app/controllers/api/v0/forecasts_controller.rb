class Api::V0::ForecastsController < ApplicationController
  def show
    data = MapquestFacade.get_lat_lon(params[:location])
    lat = data[:results].first[:locations].first[:latLng][:lat]
    lon = data[:results].first[:locations].first[:latLng][:lng]
    forecast = WeatherFacade.get_forecast(lat,lon)
    render json: WeatherSerializer.format_forecast(forecast)
  end

  def road_trip(location1, location2)
    DirectionsFacade.get_route(location1, location2)
  end
end