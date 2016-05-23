class WelcomeController < ApplicationController
  def index

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
