class UsersController < ApplicationController
  #before_action :logged_in_user, only: [:index]
  #before_action :correct_user, only: [:edit, :update, :destroy, :show]
  #before_action :admin_user, only: [:index, :destroy]
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
    @images = Image.where(user: current_user)
              .order(:created_at)
  end
    
  def new
    @user = User.new
    @user.build_location
    
  end
  
  def create
    @user = User.new(user_params) 
    if @user.save
      
      if params[:user][:photos].present?
        params[:user][:photos].each do |image|
          if image != ""
            Rails.logger.error("Print mo tempfile: #{image.tempfile}")
           cloudinary_upload = Cloudinary::Uploader.upload(image.tempfile)
           @img = @user.images.build(user: @user, cloudinary_url: cloudinary_upload['secure_url'])
            if !@img.save
              @img.errors.full_messages.each do |msg|
                Rails.logger.error("Failed to save image: #{msg}")
              end
            else
             Rails.logger.error("Uploaded: #{cloudinary_upload['secure_url']}")
            end
          end
        end
      end
    
      log_in @user
      flash[:notice] = "Welcome, User successfully created !"
      redirect_to @user
    else
      @user.errors.full_messages.each do |msg|
        Rails.logger.error("Failed to save user: #{msg}")
      end
      flash.now[:notice] = "Error creating user. Please fix the following errors:"
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
    @user.build_location if @user.location.nil?
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "Profile updated"
      redirect_to @user
    else
      flash[:notice] = "Error"
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:notice] = "User deleted"
    redirect_to users_path
  end
    
  private
    def user_params
      params.require(:user).permit(:email, :password, 
                              :password_confirmation, :first_name, :last_name, :mobile_number,
                              :birthdate, :gender, :sexual_orientation, :gender_interest,
                              :school, :bio, photos: [], :location_attributes => [:country, :state_region, :city])
    end
    
    # Before filters
    
    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:notice] = "Please log in."
        redirect_to login_path
      end
    end
    
    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
  
      unless current_user?(@user) || current_user.admin?
        flash[:notice] = "Not Authorized."
        redirect_to swipes_path
      end
    end
  
  
    #Confirms an admin user.
    def admin_user
      if current_user.nil? || !current_user.admin?
        flash[:notice] = "Not Authorized."
        redirect_to swipes_path
      end
    end
  end
