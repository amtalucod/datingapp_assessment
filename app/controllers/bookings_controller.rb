class BookingsController < ApplicationController
  before_action :set_booking, only: %i[ show edit update destroy ]
  before_action :logged_in_user, only: [:index, :edit, :update, :new, :create]
  #before_action :correct_user, only: [ :index, :edit, :update, :destroy]
  before_action :authorize_user, only: [:edit, :destroy]

  # GET /bookings or /bookings.json
  def index
    @bookings = Booking.all
  end

  # GET /bookings/1 or /bookings/1.json
  def show
    
  end

  # GET /bookings/hotel.id/new
  def new
    @hotel = Hotel.find(params[:id])
    #@booking = Booking.new
    @booking = current_user.bookings.build
  end

  # GET /bookings/1/edit
  def edit
    @hotel = @booking.hotel
  end

  # POST /bookings or /bookings.json
  def create
    @booking = Booking.new(booking_params)
    respond_to do |format|
      if @booking.save
        flash[:success] = "Booking was successfully created."
        format.html { redirect_to booking_url(@booking) }
        format.json { render :show, status: :created, location: @booking }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookings/1 or /bookings/1.json
  def update
    respond_to do |format|
      if @booking.update(booking_params)
        flash[:success] = "Booking was successfully updated."
        format.html { redirect_to booking_url(@booking) }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1 or /bookings/1.json
  def destroy
    @booking.destroy!

    respond_to do |format|
      flash[:success] = "Booking was successfully destroyed."
      format.html { redirect_to bookings_url }
      format.json { head :no_content }
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params[:id])
    end
    
    def set_user
      @user = User.find(params[:user_id])
    end

    # Only allow a list of trusted parameters through.
    def booking_params
      params.require(:booking).permit(:name, :room_type, :check_in_date, :check_out_date, :user_id, :hotel_id)
      
    end
    
    def authorize_user
      @booking = Booking.find(params[:id])
      unless @booking.user == current_user
        redirect_to root_path, notice: "You are not authorized to perform this action."
        flash[:danger] = "You are not authorized to perform this action."
      end
    end
    
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
end
