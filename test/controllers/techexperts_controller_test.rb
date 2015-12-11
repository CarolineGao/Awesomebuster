require 'test_helper'

class TechexpertsControllerTest < ActionController::TestCase
  test "should get index_techexpert" do
    get :index_techexpert
    assert_response :success
    assert_select "title", "Bugsters | Work for Curiosity"
  end

end
