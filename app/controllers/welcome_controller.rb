class WelcomeController < ApplicationController
  def index
    mapsApi = ENV['googlemaps_api_key']
    url = "https://maps.googleapis.com/maps/api/geocode/json?components=postal_code:07631&key="+mapsApi
    data = HTTParty.get(url)
    myLongitude = data['results'][0]['geometry']['location']['lng'];
    myLatitude = data['results'][0]['geometry']['location']['lat'];
  end

  def create
    user = params['user']
    User.create(name: user['name'], email: user['email'])
    BuzzbitesMailer.buzzbites_welcome(user['email']).deliver_now
    redirect_to(:back)
  end

  def destroy
    User.destroy(params['id'])
    redirect_to(:back)
  end
end
