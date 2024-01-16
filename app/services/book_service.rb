class BookService
  def self.conn
    Faraday.new(url: 'https://openlibrary.org/search.json')
  end
  
  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_book(location, quantity)
    get_url("?title=#{location}&limit=#{quantity}")
  end
end