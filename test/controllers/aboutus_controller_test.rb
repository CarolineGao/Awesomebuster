require 'test_helper'

class AboutusControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should get index_aboutus" do
    get :index_aboutus
    assert_response :success
    assert_select "title", "Bugsters | Our Story"
  end
end
