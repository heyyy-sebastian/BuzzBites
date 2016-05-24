class WelcomeController < ApplicationController
  def index
    @user = User.new
  end

  def create
    byebug
    if params['password'] == params['password_confirmation']
      newUser = User.create(name: params['name'], email: params['email'], username: params['username'], password: params['password'], loginnum: 1)
      # newUser = User.create(user_params)
      if newUser
        # format.html { redirect_to @user, notice: 'You are now a member!' }
        # format.json { render :index, status: :created, location: @user }
        BuzzbitesMailer.buzzbites_welcome(params['email']).deliver_now
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
        loginnum = @user["loginnum"]
      if @user.is_password?(password)
        byebug
        session["id"] = @user["id"]
        loginnum = loginnum + 1
        @user.update(loginnum: loginnum)
        render :index
      end
      render text: "Invalid username/password."
    end
  end

  # def logout
  #     session.delete("id")
  #     redirect_to "/"
  # end

  private
    def user_params
      params.require(:user).permit(:name, :email, :username, :password, loginnum: 1)
    end
end
