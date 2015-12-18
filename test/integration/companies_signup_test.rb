require 'test_helper'

class CompaniesSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get companies_signup_path
    assert_no_difference 'Company.count' do
      post companies_path, company: { first_name: "  ",
                                      last_name: "  ",
                                      company_name: "   ",
                                      email: "company@invalid",
                                      password:              "foo",
                                      password_confirmation: "bar" }
    end
    assert_template 'companies/new'
  end

  test "valid signup information" do
    get companies_signup_path
    assert_difference 'Company.count', 1 do
      post_via_redirect companies_path, company: { first_name: "Example",
                                                   last_name: "Company",
                                                   company_name: "Company name",
                                                   email: "company@example.com",
                                                   password:              "password",
                                                   password_confirmation: "password" }
    end
    assert_template 'companies/show'
  end
end
