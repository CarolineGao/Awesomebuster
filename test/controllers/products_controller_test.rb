require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  test "should get index_product" do
    get :index_product
    assert_response :success
    assert_select "title", "Bugsters | Work for Curiosity"
  end

end
