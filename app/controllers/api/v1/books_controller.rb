class Api::V1::BooksController < ApplicationController
  def search
    if params[:quantity].to_i > 0
      render json: BookFacade.get_book(params[:location], params[:quantity])
    else
      render json: { error: "Quantity must be greater than 0."}
    end
  end
end