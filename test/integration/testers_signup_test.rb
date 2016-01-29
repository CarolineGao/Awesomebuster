require 'test_helper'

class TestersSignupTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
  end

  test "invalid signup information" do
    get testers_signup_path
    assert_no_difference 'Tester.count' do
      post testers_path, tester: { name: " ",
                                   email: "tester@invalid",
                                   password:              "foo",
                                   password_confirmation: "bar" }
    end
    assert_template 'testers/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test "valid signup information with account activation" do
    get testers_signup_path
    assert_difference 'Tester.count', 1 do
      post testers_path, tester: { name: "Example User",
                                   email: "tester@example.com",
                                   password:              "password",
                                   password_confirmation: "password" }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    tester = assigns(:tester)
    assert_not tester.activated?
    # Try to log in before activation.
    log_in_as(tester)
    assert_not is_logged_in?
    # Invalid activation token
    get edit_account_activation_path("invalid token")
    assert_not is_logged_in?
    # Valid token, wrong email
    get edit_account_activation_path(tester.activation_token, email: 'wrong')
    assert_not is_logged_in?
    # Valid activation token
    get edit_account_activation_path(tester.activation_token, email: tester.email)
    assert tester.reload.activated?
    follow_redirect!
    assert_template 'testers/show'
    assert is_logged_in?
  end
end
