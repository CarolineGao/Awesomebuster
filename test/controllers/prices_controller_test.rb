require 'test_helper'

class PricesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_select "title", "Bugsters | Work for Curiosity"
  end

end
