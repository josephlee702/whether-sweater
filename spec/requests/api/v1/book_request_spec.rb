require 'rails_helper'
		
describe "Book API" do
  it "returns books JSON data", :vcr do    
    get "/api/v1/book-search", params: {
      location: "Denver,CO",
      quantity: "2"
    }
    expect(response).to be_successful

    books_data = JSON.parse(response.body, symbolize_names: true)
    books = books_data[:data]

    expect(books).to have_key(:id)
    expect(books[:id]).to eq(nil)
    expect(books).to have_key(:type)
    expect(books[:type]).to eq("books")
    expect(books).to have_key(:attributes)
    expect(books[:attributes]).to have_key(:destination)
    expect(books[:attributes][:destination]).to be_a(String)
    expect(books[:attributes][:destination]).to eq("Denver,CO")

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

  it "does not return irrelevant JSON data", :vcr do
    get "/api/v1/book-search", params: {
      location: "Denver,CO",
      quantity: "2"
    }

    expect(response).to be_successful

    books_data = JSON.parse(response.body, symbolize_names: true)
    books = books_data[:data]

    expect(books[:attributes][:books].first).to_not have_key(:type)
    expect(books[:attributes][:books].first).to_not have_key(:seed)
    expect(books[:attributes][:books].first).to_not have_key(:edition_count)
    expect(books[:attributes][:books].first).to_not have_key(:publish_date)
    expect(books[:attributes][:books].first).to_not have_key(:last_modified_i)
  end
end