require 'geocoder'
require 'foursquare2'
require 'yelp'

class WelcomeController < ApplicationController
  include ApplicationHelper

  def index
    @user = User.new
    # client = Yelp::Client.new({ consumer_key: ENV['YELP_CONSUMER_KEY'],
    #                         consumer_secret: ENV['YELP_CONSUMER_SECRET'],
    #                         token: ENV['YELP_TOKEN'],
    #                         token_secret: ENV['YELP_TOKEN_SECRET']
    #                       })
    # params = { term: 'food', limit: 3, category_filter: 'discgolf' }

    # locale = { lang: 'fr' }

    # @response = client.search('San Francisco', params, locale)
    # # byebug
    # @response = @response.businesses[0].name
    @response = Geocoder.search("44.981667,-93.27833")
  end

  def create
    if params['password'] == params['password_confirmation']
      password = params['password']
      newUser = User.create(name: params['name'], email: params['email'], username: params['username'], password: params['password'], loginnum: 1)
      # newUser = User.create(user_params)
      if newUser
        # format.html { redirect_to @user, notice: 'You are now a member!' }
        # format.json { render :index, status: :created, location: @user }
        session[:user_id] = newUser.id
        # BuzzbitesMailer.buzzbites_welcome(params['email']).deliver_now
      else
        format.html { render :index }
        # format.json { render json: @user.errors, status: :unprocessable_entity }
        # render "Incorrect information"
      end
    end
    redirect_to(:back)
  end

  def login
    # Add one to each login a user has
    username = params['username']
    password = params['password']
    if  @user = User.find_by(username: username)
        # loginnum = @user.loginnum
      if @user.is_password?(password)
        session[:user_id] = @user.id
        # loginnum = loginnum + 1
        # @user.update(loginnum: loginnum.to_i)
        render :index
      else
        render text: "Invalid username/password."
      end
    end
  end

  def logout
      session.delete(:user_id)
      redirect_to "/"
  end

  # private
  #   def user_params
  #     params.require(:user).permit(:name, :email, :username, :password, loginnum: 1)
  #   end
end
