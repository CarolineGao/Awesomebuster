require 'test_helper'

class BlogsControllerTest < ActionController::TestCase
  test "should get index_blog" do
    get :index_blog
    assert_response :success
    assert_select "title", "Bugsters | Work for Curiosity"
  end

end
