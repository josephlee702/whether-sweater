class Api::V0::ForecastsController < ApplicationController
  def show
    coordinates = MapquestFacade.get_lat_lon(params[:location])

    

    # data = MapquestFacade.get_lat_lon(params[:location])
    # lat = data[:results].first[:locations].first[:latLng][:lat]
    # lon = data[:results].first[:locations].first[:latLng][:lng]
    # forecast = WeatherFacade.get_forecast(lat,lon)
    # render json: WeatherSerializer.format_forecast(forecast)
  end
end