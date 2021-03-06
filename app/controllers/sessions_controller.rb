class SessionsController < ApplicationController
  def new
  end

  def create
    tester = Tester.find_by(email: params[:session][:email].downcase)
    if tester && tester.authenticate(params[:session][:password])
      if tester.activated?
        # Log the tester in and redirect to the tester's show page.
        log_in tester
        params[:session][:remember_me] == '1' ? remember(tester) : forget(tester)
        redirect_back_or tester
      else
        message = "Account not activated."
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      # Create an error message.
      flash.now[:danger] = 'Invalid email or password'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
