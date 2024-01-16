require 'rails_helper'
		
describe "MapQuest Facade" do
  describe "#get_lat_lon", :vcr do
    it "returns coordinates data" do
      response = MapquestFacade.get_lat_lon("denver,co")

      expect(response).to eq(["39.74001", "-104.99202"])
    end
  end
end