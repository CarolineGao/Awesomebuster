require 'test_helper'

class CareerControllerTest < ActionController::TestCase
  test "should get index_career" do
    get :index_career
    assert_response :success
    assert_select "title", "Bugsters | Work for Curiosity"
  end

end
