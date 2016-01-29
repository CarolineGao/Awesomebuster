require 'test_helper'

class TesterMailerTest < ActionMailer::TestCase
  test "account_activation" do
    tester = testers(:caroline)
    tester.activation_token = Tester.new_token
    mail = TesterMailer.account_activation(tester)
    assert_equal "Account activation", mail.subject
    assert_equal [tester.email], mail.to
    assert_equal ["noreply@example.com"],   mail.from
    assert_match tester.name,               mail.body.encoded
    assert_match tester.activation_token,   mail.body.encoded
    assert_match CGI::escape(tester.email), mail.body.encoded
  end
end
