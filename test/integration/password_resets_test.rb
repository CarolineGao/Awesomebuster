require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
    @tester = testers(:caroline)
  end

  test "password resets" do
    get new_password_reset_path
    assert_template 'password_resets/new'
    # Invalid email
    post password_resets_path, password_reset: { email: "" }
    assert_not flash.empty?
    assert_template 'password_resets/new'
    # Valid email
    post password_resets_path, password_reset: { email: @tester.email }
    assert_not_equal @tester.reset_digest, @tester.reload.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to root_url
    # Password reset form
    tester = assigns(:tester)
    # Wrong email
    get edit_password_reset_path(tester.reset_token, email: "")
    assert_redirected_to root_url
    # Inactive tester
    tester.toggle!(:activated)
    get edit_password_reset_path(tester.reset_token, email: tester.email)
    assert_redirected_to root_url
    tester.toggle!(:activated)
    # Right email, wrong token
    get edit_password_reset_path('wrong token', email: tester.email)
    assert_redirected_to root_url
    # Right email, right token
    get edit_password_reset_path(tester.reset_token, email: tester.email)
    assert_template 'password_resets/edit'
    assert_select "input[name=email][type=hidden][value=?]", tester.email
    # Invalid password & confirmation
    patch password_reset_path(tester.reset_token),
          email: tester.email,
          tester: { password:              "foobaz",
                    password_confirmation: "barquux" }
    assert_select 'div#error_explanation'
    # Empty password
    patch password_reset_path(tester.reset_token),
          email: tester.email,
          tester: { password:              "",
                    password_confirmation: "" }
    assert_select 'div#error_explanation'
    # Valid password & confirmation
    patch password_reset_path(tester.reset_token),
          email: tester.email,
          tester: { password:              "foobaz",
                    password_confirmation: "foobaz" }
    assert is_logged_in?
    assert_not flash.empty?
    assert_redirected_to tester
  end
end
