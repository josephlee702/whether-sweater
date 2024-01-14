class Api::V0::LocationsController < ApplicationController
  def show
    data = MapquestFacade.get_lat_lon(params[:location])
    lat = data[:results].first[:locations].first[:latLng][:lat]
    lon = data[:results].first[:locations].first[:latLng][:lng]
    forecast = WeatherFacade.get_forecast(lat,lon)
    render json: WeatherSerializer.format_forecast(forecast)
  end
end