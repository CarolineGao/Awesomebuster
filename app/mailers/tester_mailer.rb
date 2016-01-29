class TesterMailer < ApplicationMailer

  def account_activation(tester)
    @tester = tester
    mail to: tester.email, subject: "Account activation"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.tester_mailer.password_reset.subject
  #
  def password_reset(tester)
    @tester = tester
    mail to: tester.email, subject: "Password reset"
  end
end
