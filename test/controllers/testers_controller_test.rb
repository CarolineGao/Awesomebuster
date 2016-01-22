require 'test_helper'

class TestersControllerTest < ActionController::TestCase

  def setup
    @tester = testers(:caroline)
    @other_tester = testers(:david)
  end

  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to login_url
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get :edit, id: @tester
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch :update, id: @tester, tester: { name: @tester.name, email: @tester.email }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when logged in as wrong tester" do
    log_in_as(@other_tester)
    get :edit, id: @tester
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong tester" do
    log_in_as(@other_tester)
    patch :update, id: @tester, tester: { name: @tester.name, email: @tester.email }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Tester.count' do
      delete :destroy, id: @tester
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_tester)
    assert_no_difference 'Tester.count' do
      delete :destroy, id: @tester
    end
    assert_redirected_to root_url
  end
end
