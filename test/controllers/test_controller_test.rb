require "test_helper"

class TestControllerTest < ActionDispatch::IntegrationTest
  test "should get cloudinary_test" do
    get test_cloudinary_test_url
    assert_response :success
  end
end
