require 'rails_helper'
		
describe "Yelp Facade" do
  describe "#get_restaurant" do
    it "returns restaurant JSON data" do
      response = YelpFacade.get_restaurant("denver,co", "asian")

      expect(response[:businesses]).to be_an(Array)
      expect(response[:businesses].count).to eq(1)

      expect(response[:businesses].first).to have_key(:id)
      expect(response[:businesses].first).to have_key(:alias)
      expect(response[:businesses].first).to have_key(:name)
      expect(response[:businesses].first).to have_key(:image_url)
      expect(response[:businesses].first).to have_key(:is_closed)
      expect(response[:businesses].first).to have_key(:url)
      expect(response[:businesses].first).to have_key(:review_count)
      expect(response[:businesses].first).to have_key(:categories)
      expect(response[:businesses].first).to have_key(:rating)
      expect(response[:businesses].first).to have_key(:coordinates)
      expect(response[:businesses].first).to have_key(:transactions)
      expect(response[:businesses].first).to have_key(:location)
      expect(response[:businesses].first).to have_key(:phone)
      expect(response[:businesses].first).to have_key(:display_phone)
      expect(response[:businesses].first).to have_key(:distance)
    end
  end
end
