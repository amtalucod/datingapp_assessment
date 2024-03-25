require "test_helper"

class HotelsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @hotel = hotels(:one)
  end

  test "should get index" do
    get hotels_url
    assert_response :success
  end

  test "should get new" do
    get new_hotel_url
    assert_response :success
  end

  test "should create hotel" do
    assert_difference("Hotel.count") do
      post hotels_url, params: { hotel: { amenities_string: @hotel.amenities_string, contact_number: @hotel.contact_number, description: @hotel.description, hotel_name: @hotel.hotel_name, location: @hotel.location, pricing: @hotel.pricing } }
    end

    assert_redirected_to hotel_url(Hotel.last)
  end

  test "should show hotel" do
    get hotel_url(@hotel)
    assert_response :success
  end

  test "should get edit" do
    get edit_hotel_url(@hotel)
    assert_response :success
  end

  test "should update hotel" do
    patch hotel_url(@hotel), params: { hotel: { amenities_string: @hotel.amenities_string, contact_number: @hotel.contact_number, description: @hotel.description, hotel_name: @hotel.hotel_name, location: @hotel.location, pricing: @hotel.pricing } }
    assert_redirected_to hotel_url(@hotel)
  end

  test "should destroy hotel" do
    assert_difference("Hotel.count", -1) do
      delete hotel_url(@hotel)
    end

    assert_redirected_to hotels_url
  end
end
