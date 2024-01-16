require 'rails_helper'
		
describe "Book Facade" do
  describe "#get_book", :vcr do
    it "returns the desired JSON data" do
      books_data = BookFacade.get_book("denver,co", "2")
      books = books_data[:data]

      expect(books).to have_key(:id)
      expect(books[:id]).to eq(nil)
      expect(books).to have_key(:type)
      expect(books[:type]).to eq("books")
      expect(books).to have_key(:attributes)
      expect(books[:attributes]).to have_key(:destination)
      expect(books[:attributes][:destination]).to be_a(String)
      expect(books[:attributes][:destination]).to eq("denver,co")

      expect(books[:attributes]).to have_key(:forecast)
      expect(books[:attributes][:forecast]).to be_a(Hash)
      expect(books[:attributes][:forecast]).to have_key(:summary)
      expect(books[:attributes][:forecast]).to have_key(:temperature)

      expect(books[:attributes]).to have_key(:total_books_found)
      expect(books[:attributes][:total_books_found]).to be_an(Integer)

      expect(books[:attributes]).to have_key(:books)
      expect(books[:attributes][:books]).to be_an(Array)
      expect(books[:attributes][:books].count).to eq(2)

      expect(books[:attributes][:books].first).to have_key(:author_name)
      expect(books[:attributes][:books].first[:author_name]).to be_an(Array)
      expect(books[:attributes][:books].first).to have_key(:title)
      expect(books[:attributes][:books].first[:title]).to be_a(String)
      expect(books[:attributes][:books].first).to have_key(:publisher)
      expect(books[:attributes][:books].first[:publisher]).to be_an(Array)
    end
  end
end