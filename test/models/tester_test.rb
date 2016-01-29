require 'test_helper'

class TesterTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @tester = Tester.new(name: "Example Tester", email: "tester@example.com", password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @tester.valid?
  end

  test "name should be present" do
    @tester.name = "    "
    assert_not @tester.valid?
  end

  test "email should be present" do
    @tester.email = "    "
    assert_not @tester.valid?
  end

  test "name should not be too long" do
    @tester.name = "a" * 51
    assert_not @tester.valid?
  end

  test "email should not be too long" do
    @tester.email = "a" * 244 + "@example.com"
    assert_not @tester.valid?
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @tester.email = invalid_address
      assert_not @tester.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_tester = @tester.dup
    @tester.save
    assert_not duplicate_tester.valid?
  end

  test "password should be present (nonblank)" do
    @tester.password = @tester.password_confirmation = " " * 6
    assert_not @tester.valid?
  end

  test "password should have a minimum length" do
    @tester.password = @tester.password_confirmation = "a" * 5
    assert_not @tester.valid?
  end

  test "authenticated? should return false for a tester with nil digest" do
    assert_not @tester.authenticated?(:remember, '')
  end
end
