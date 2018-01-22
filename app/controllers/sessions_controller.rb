class SessionsController < ApplicationController
  def new
  end

  def create

    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      remember user
      redirect_to user
      flash[:primary] = "You're now logged in!"
    else
      flash.now[:alert] = 'Invalid credentials. Pleasse try again'
      render 'new'
    end
  end

  def destroy
    log_out
    flash[:primary] = 'Bye, See you soon!'
    redirect_to root_path
  end
end
