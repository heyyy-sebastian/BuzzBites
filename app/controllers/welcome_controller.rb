class WelcomeController < ApplicationController
  def index
    mapsApi = ENV['googlemaps_api_key']
    url = "https://maps.googleapis.com/maps/api/geocode/json?components=postal_code:07631&key="+mapsApi
    data = HTTParty.get(url)
    myLongitude = data['results'][0]['geometry']['location']['lng'];
    myLatitude = data['results'][0]['geometry']['location']['lat'];
  end
end
