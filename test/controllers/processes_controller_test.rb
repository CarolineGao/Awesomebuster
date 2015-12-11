require 'test_helper'

class ProcessesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_select "title", "Bugsters | How it Works"
  end

end
