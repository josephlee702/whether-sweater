class YelpFacade
  def self.get_restaurant(location, term)
    YelpService.get_url("?location=#{location}&term=#{term}&limit=1")
  end
end
