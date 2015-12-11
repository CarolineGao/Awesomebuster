require 'test_helper'

class ContactsControllerTest < ActionController::TestCase
  test "should get index_contact" do
    get :index_contact
    assert_response :success
    assert_select "title", "Bugsters | Work for Curiosity"
  end

end
