class WelcomeController < ApplicationController
  def index

  end

  def create
    user = params['user']
    if user['password'] == user['password_confirmation']
      newUser = User.create(name: user['name'], email: user['email'], username: user['username'], password: user['password'])
      if newUser
        BuzzbitesMailer.buzzbites_welcome(user['email']).deliver_now
      end
    end
    redirect_to(:back)
  end
end
