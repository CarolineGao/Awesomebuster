require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @company = Company.new(first_name: "Example", last_name: "Company", company_name: "Company name", email: "company@example.com",
                           password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @company.valid?
  end

  test "first_name should be present" do
    @company.first_name = "   "
    assert_not @company.valid?
  end

  test "last_name should be present" do
    @company.last_name = "   "
    assert_not @company.valid?
  end

  test "company_name should be present" do
    @company.company_name = "   "
    assert_not @company.valid?
  end

  test "email should be present" do
    @company.email = "    "
    assert_not @company.valid?
  end

  test "first_name should not be too long" do
    @company.first_name = "a" * 51
    assert_not @company.valid?
  end

  test "last_name should not be too long" do
    @company.last_name = "a" * 51
  end

  test "company_name should not be too long" do
    @company.company_name = "a" * 51
  end

  test "email should not be too long" do
    @company.email = "a" * 244 + "@exmaple.com"
    assert_not @company.valid?
  end

  test "email validation should reject invalid addresses" do
      invalid_addresses = %w[company@example,com user_at_foo.org user.name@example.
                             foo@bar_baz.com foo@bar+baz.com]
      invalid_addresses.each do |invalid_address|
        @company.email = invalid_address
        assert_not @company.valid?, "#{invalid_address.inspect} should be invalid"
      end
  end

  test "email addresses should be unique" do
    duplicate_user = @company.dup
    @company.save
    assert_not duplicate_user.valid?
  end

  test "password should be present (nonblank)" do
    @company.password = @company.password_confirmation = " " * 6
    assert_not @company.valid?
  end

  test "password should have a minimum length" do
    @company.password = @company.password_confirmation = "a" * 5
    assert_not @company.valid?
  end

end
