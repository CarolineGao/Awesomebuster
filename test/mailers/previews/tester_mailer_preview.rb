# Preview all emails at http://localhost:3000/rails/mailers/tester_mailer
class TesterMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/tester_mailer/account_activation
  def account_activation
    tester = Tester.first
    tester.activation_token = Tester.new_token
    TesterMailer.account_activation(tester)
  end

  # Preview this email at http://localhost:3000/rails/mailers/tester_mailer/password_reset
  def password_reset
    tester = Tester.first
    tester.reset_token = Tester.new_token
    TesterMailer.password_reset(tester)
  end

end
