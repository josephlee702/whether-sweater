class BookFacade
  def self.get_book(location, quantity)
    forecast_data = WeatherFacade.get_forecast(location)
    forecast = forecast_data[:data][:attributes]

    books_response = BookService.get_book(location, quantity)

    build_books_data(books_response, forecast, location)
  end

private

  def self.build_books_data(books_response, forecast, location)
    {
      "data": {
        "id": nil,
        "type": "books",
        "attributes": {
          "destination": location,
          "forecast": {
            "summary": forecast[:current_weather][:condition],
            "temperature": "#{forecast[:current_weather][:temperature]} F",
          },
          "total_books_found": books_response[:numFound],
          "books": construct_all_books(books_response[:docs])
        }
      } 
    }
  end

  def self.construct_all_books(book_index)
    book_index.map do |book|
      {
        "author_name": book[:author_name],
        "title": book[:title],
        "publisher": book[:publisher]
      }
    end
  end
end