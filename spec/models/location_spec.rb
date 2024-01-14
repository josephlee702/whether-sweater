require 'rails_helper'

RSpec.describe Location, type: :model do
  it "creates a location with city and state attributes" do
    location = Location.create(city: "Denver", state: "CO")
    expect(location).to have_attributes(city: 'Denver')
    expect(location).to have_attributes(state: 'CO')
  end
end
