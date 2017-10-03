require 'test_helper'

class ConversionsControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get conversions_home_url
    assert_response :success
  end

end
