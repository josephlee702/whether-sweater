class Api::V1::BooksController < ApplicationController
  def search
    render json: BookFacade.get_book(params[:location], params[:quantity])
  end
end