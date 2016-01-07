require 'test_helper'

class SessionsHelperTest < ActionView::TestCase

  def setup
    @tester = testers(:caroline)
    remember(@tester)
  end

  test "current_tester returns right tester when session is nil" do
    assert_equal @tester, current_tester
    assert is_logged_in?
  end

  test "current_tester returns nil when remember digest is wrong" do
    @tester.update_attribute(:remember_digest, Tester.digest(Tester.new_token))
    assert_nil current_tester
  end
end
