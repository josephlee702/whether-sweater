class Api::V0::ForecastsController < ApplicationController
  def show
    render json: WeatherFacade.get_forecast(params[:location])
  end
end