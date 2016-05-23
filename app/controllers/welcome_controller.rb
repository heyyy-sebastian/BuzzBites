class WelcomeController < ApplicationController
  def index
    @user = User.new
  end

  def create
    @user = params['user']
    if @user['password'] == @user['password_confirmation']
      newUser = User.create(name: @user['name'], email: @user['email'], username: @user['username'], password: @user['password'], loginnum: 1)
      # newUser = User.create(user_params)
      if newUser
        BuzzbitesMailer.buzzbites_welcome(@user['email']).deliver_now
      else
        render "Incorrect information"
      end
    end
    # byebug
    redirect_to(:back)
  end

  def put
    # Add one to each login a user has
    username = params['username']
    password = params['password']
    loginAttempt = User.update(username: username,
                                password: password,
                                loginnum: loginnum)
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :username, :password)
    end
end
