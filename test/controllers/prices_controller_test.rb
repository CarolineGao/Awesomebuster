require 'test_helper'

class PricesControllerTest < ActionController::TestCase
  test "should get index_price" do
    get :index_price
    assert_response :success
    assert_select "title", "Bugsters | Work for Curiosity"
  end

end
