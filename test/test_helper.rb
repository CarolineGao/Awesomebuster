ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Returns true if a test user is logged in.
  def is_logged_in?
    !session[:tester_id].nil?
  end

  # Logs in a test user.
  def log_in_as(tester, options = {})
    password     = options[:password]     || 'password'
    remember_me  = options[:remember_me]  || '1'
    if integration_test?
      post login_path, session: { email:       tester.email,
                                  password:    password,
                                  remember_me: remember_me }
    else
      session[:tester_id] = tester.id
    end
  end

  private

     # Return true inside an integration test.
     def integration_test?
       defined?(post_via_redirect)
     end
end
