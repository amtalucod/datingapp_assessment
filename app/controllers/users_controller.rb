class UsersController < ApplicationController
  #before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  #before_action :correct_user, only: [:edit, :update]
  #before_action :admin_user, only: :destroy
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
    
  end
    
  def new
    @user = User.new
    @user.build_location
    
  end
  
  def create
    @user = User.new(user_params) 
    
    
    if params[:user][:photos].present?
      begin
        cloudinary_response = Cloudinary::Uploader.upload(params[:user][:photos].tempfile)
        @user.photos = cloudinary_response['secure_url']
      end
    end
    
    #Save the associated images to Cloudinary
      #if params[:user][:photos].present?
      #  params[:user][:photos].each do |photo|
      #    cloudinary_upload = Cloudinary::Uploader.upload(photo.tempfile)
      #    @user.photos.create(cloudinary_url: cloudinary_upload['secure_url'])
      #  end
      #end
    if @user.save
      
      
      #if params[:user][:photos].present?
      #  begin
      #    cloudinary_response = Cloudinary::Uploader.upload(params[:user][:photos].tempfile)
      #    @user.photos = cloudinary_response['secure_url']
      #  end
      #end
      #params[:photos].each do |photo|
      #  Cloudinary::Uploader.upload(photo.tempfile, options)
      #end
      
      
      log_in @user
      flash[:success] = "Welcome !"
      redirect_to @user
    else
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
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
    
    #@user = User.find(params[:id])
#
    ## Delete associated swipes
    #Swipe.where(user_id: @user.id).destroy_all
#
    ## Now, you can safely delete the user
    #@user.destroy
#
    #redirect_to users_path, notice: "User deleted successfully."
  end
    
  private
    def user_params
      params.require(:user).permit(:email, :password, 
                              :password_confirmation, :first_name, :last_name, :mobile_number,
                              :birthdate, :gender, :sexual_orientation, :gender_interest,
                              :school, :bio, :photos, :location_attributes => [:country, :state_region, :city])
    end
    
    # Before filters
    
    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
    end
    
    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
  end
  
  #Confirms an admin user.
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
