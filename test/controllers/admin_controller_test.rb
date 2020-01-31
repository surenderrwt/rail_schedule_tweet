require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest
  test "should get user" do
    get admin_user_url
    assert_response :success
  end

end
