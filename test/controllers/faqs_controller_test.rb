require 'test_helper'

class FaqsControllerTest < ActionController::TestCase
  test "should get index_faq" do
    get :index_faq
    assert_response :success
    assert_select "title", "Bugsters | Work for Curiosity"
  end

end
