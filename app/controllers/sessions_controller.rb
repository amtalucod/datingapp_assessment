class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      flash[:notice] = 'Welcome, You have been logged in successfully !'
      redirect_back_or user
    else  
      flash.now[:notice] = 'Invalid email/password combination'
      render 'new'
    end
  end
  
  def destroy
    log_out
    flash[:notice] = 'You have been logged out successfully !'
    redirect_to login_path
  end
end
