require 'test_helper'

class BustersControllerTest < ActionController::TestCase
  test "should get index_buster" do
    get :index_buster
    assert_response :success
    assert_select "title", "Bugsters | Work for Curiosity"
  end

end
