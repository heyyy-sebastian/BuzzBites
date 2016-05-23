class BuzzbitesMailer < ApplicationMailer
  default from: 'genericident@gmail.com'
  def buzzbites_welcome(user)
    @user = user
    mail(to: @user, subject:"BuzzBites!")
  end
end
