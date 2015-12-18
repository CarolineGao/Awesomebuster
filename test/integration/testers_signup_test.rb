require 'test_helper'

class TestersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get testers_signup_path
    assert_no_difference 'Tester.count' do
      post testers_path, tester: { name: " ",
                                   email: "tester@invalid",
                                   password:              "foo",
                                   password_confirmation: "bar" }
    end
    assert_template 'testers/new'
  end

  test "valid signup information" do
    get testers_signup_path
    assert_difference 'Tester.count', 1 do
      post_via_redirect testers_path, tester: { name: "Example User",
                                                email: "tester@example.com",
                                                password:              "password",
                                                password_confirmation: "password" }
    end
    assert_template 'testers/show'
  end
end
