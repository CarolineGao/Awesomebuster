require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get terms" do
    get :terms
    assert_response :success
  end

end
