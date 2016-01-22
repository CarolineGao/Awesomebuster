require 'test_helper'

class TestersEditTest < ActionDispatch::IntegrationTest
  def setup
    @tester = testers(:caroline)
  end

  test "unsuccessful edit" do
    log_in_as(@tester)
    get edit_tester_path(@tester)
    assert_template 'testers/edit'
    patch tester_path(@tester), tester: { name: "",
                                          email: "foo@invalid",
                                          password:               "foo",
                                          password_confirmation:  "foo" }
    assert_template 'testers/edit'
  end

  test "successful edit with friendly forwarding" do
    get edit_tester_path(@tester)
    log_in_as(@tester)
    assert_redirected_to edit_tester_path(@tester)
    name = "Caroline Gao"
    email = "carolinegao@tester.com"
    patch tester_path(@tester), tester: { name: name,
                                          email: email,
                                          password:               "",
                                          password_confirmation:  "" }
    assert_not flash.empty?
    assert_redirected_to @tester
    @tester.reload
    assert_equal name,  @tester.name
    assert_equal email, @tester.email
  end
end
