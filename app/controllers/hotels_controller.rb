class HotelsController < ApplicationController
  before_action :set_hotel, only: %i[ show edit update destroy ]
  before_action :logged_in_user, only: [:edit, :update, :destroy, :new, :create]
  before_action :admin_user, only: [:destroy, :edit, :update, :new, :create ]

  # GET /hotels or /hotels.json
  def index
    @hotels = Hotel.all
  end

  # GET /hotels/1 or /hotels/1.json
  def show
    @hotel = Hotel.find(params[:id])
  end

  # GET /hotels/new
  def new
    @hotel = Hotel.new
  end

  # GET /hotels/1/edit
  def edit
  end
  
  

  # POST /hotels or /hotels.json
  def create
    @hotel = Hotel.new(hotel_params)
    
    respond_to do |format|
      if @hotel.save
        flash[:success] = "Hotel was successfully created"
        format.html { redirect_to hotel_url(@hotel)}
        format.json { render :show, status: :created, location: @hotel }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @hotel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hotels/1 or /hotels/1.json
  def update
    respond_to do |format|
      if @hotel.update(hotel_params)
        flash[:success] = "Hotel was successfully updated."
        format.html { redirect_to hotel_url(@hotel) }
        format.json { render :show, status: :ok, location: @hotel }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @hotel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hotels/1 or /hotels/1.json
  def destroy
    @hotel.destroy!

    respond_to do |format|
      flash[:success] = "Hotel was successfully destroyed."
      format.html { redirect_to hotels_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hotel
      @hotel = Hotel.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def hotel_params
      params.require(:hotel).permit(:hotel_name, :description, :location, :contact_number, :amenities, :pricing, :user_id)
    end
    
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
    
    def admin_user
      unless current_user.admin?
      
        flash[:danger] = "Authorize User Only."
        redirect_to(root_url) 
      end
    end
  
end
