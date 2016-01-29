class AccountActivationsController < ApplicationController

  def edit
    tester = Tester.find_by(email: params[:email])
    if tester && !tester.activated? && tester.authenticated?(:activation, params[:id])
      tester.activate
      log_in tester
      flash[:success] = "Account activated!"
      redirect_to tester
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
end
