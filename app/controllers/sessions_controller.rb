class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      
      if user.admin?
        flash[:notice] = 'Welcome Admin, You have been logged in successfully !'
        redirect_to users_path
      else
        flash[:notice] = 'Welcome, You have been logged in successfully !'
        redirect_back_or swipes_path
      end
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
