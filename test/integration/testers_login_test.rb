require 'test_helper'

class TestersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @tester = testers(:caroline)
  end

  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, session: { email: " ", password: " " }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "login with valid information followed by logout" do
    get login_path
    post login_path, session: { email: @tester.email, password: 'password' }
    assert is_logged_in?
    assert_redirected_to @tester
    follow_redirect!
    assert_template 'testers/show'
    assert_select "a[href=?]", login_path,           count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", tester_path(@tester)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    # Simulate a user clicking logout in a second window.
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,          count: 0
    assert_select "a[href=?]", tester_path(@tester), count: 0
  end

  test "login with remembering" do
    log_in_as(@tester, remember_me: '1')
    assert_not_nil cookies['remember_token']
  end

  test "login without remembering" do
    log_in_as(@tester, remember_me: '0')
    assert_nil cookies['remember_token']
  end
end
