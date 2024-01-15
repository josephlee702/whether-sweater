class Api::V1::MunchiesController < ApplicationController
  def show
    restaurant_data = YelpFacade.get_restaurant(params[:location], params[:term])
    restaurant = restaurant_data[:businesses].first
    render json: YelpSerializer.format_restaurant(restaurant)
  end
end