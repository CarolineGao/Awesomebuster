require 'test_helper'

class ProcessesControllerTest < ActionController::TestCase
  test "should get index_process" do
    get :index_process
    assert_response :success
    assert_select "title", "Bugsters | How it Works"
  end

end
